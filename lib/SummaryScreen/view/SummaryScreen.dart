import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/SummaryData.dart';
import 'package:valet_app/Dialog/NetworkImageDialog.dart';
import 'package:valet_app/SummaryScreen/presenter/SummaryPresenterImpl.dart';
import 'package:valet_app/SummaryScreen/view/SummaryScreenView.dart';
import 'package:valet_app/SummaryScreenWidget/view/SummaryScreenWidget.dart';
import 'package:valet_app/Util/Utils.dart';

import '../../ConnectivityStatusSingleton.dart';
import '../../Util/Strings.dart';
import '../../Widgets/AppBarWidget/View/AppBarWidget.dart';

class SummaryScreen extends StatefulWidget {
  static const String routeName = 'SummaryScreen';
  SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    implements SummaryScreenView {
  late SummaryPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  TextEditingController vmController = TextEditingController();
  List<SummaryData> summaryData = [];
  bool isLoading = false;
  bool isOffline = false;
  bool _customTileExpanded = false;
  List<String> visibleFieldList = [];

  _SummaryScreenState() {
    _presenter = SummaryPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _presenter.getData(''));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Column(
            children: [
              AppBarWidget(
                onNewEntryClick,
                onRefreshClick,
                onMenuClicked,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        style: const TextStyle(fontSize: 20),
                        controller: vmController,
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          onVMChanged(text);
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColorDark,
                              size: 25,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: Strings.SEARCH_VEHICLE_MOBILE,
                            hintStyle: const TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: summaryData.length,
                    itemBuilder: (context, index) =>
                        SummaryScreenWidget(summaryData[index])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> isOnline() async {
    return isOffline = await connectionStatus.checkConnection();
  }

  @override
  void showOfflineMessage() {
    showErrorMsg(Strings.OFFLINE_MESSAGE);
    if (isLoading) {
      hideProgress();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void showProgress() {
    // TODO: implement showProgress

    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
              height: 30,
              width: 30,
              child: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)));
        },
      );
    }
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
    if (isLoading) {
      isLoading = false;
      Navigator.pop(context);
    }
  }

  @override
  void showErrorMsg(String? msg) {
    Utils.showToastMsg(msg!,
        textColor: Colors.black, backgroundColor: Colors.white);
  }

  @override
  void setSummaryData(List<SummaryData> summaryData) {
    // TODO: implement setExitDataList
    this.summaryData = summaryData;
    if (mounted) setState(() {});
  }

  void onVMChanged(String text) {
    _presenter.getData(text, showLoading: false);
  }

  void onNewEntryClick() {
    Navigator.of(context).pop(true);
  }

  void onRefreshClick() {
    vmController.text = '';
    _presenter.getData('');
  }

  void onMenuClicked() {
    Navigator.of(context).pop();
  }
}
