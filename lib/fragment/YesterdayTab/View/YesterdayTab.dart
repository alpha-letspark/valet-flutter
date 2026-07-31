import 'package:flutter/material.dart';
import 'package:valet_app/ConnectivityStatusSingleton.dart';
import 'package:valet_app/Data/Response/HistoryData.dart';
import 'package:valet_app/fragment/YesterdayTab/Presenter/YesterdayTabPresenterImpl.dart';
import 'package:valet_app/fragment/YesterdayTab/View/YesterdayTabView.dart';

import '../../../Util/Strings.dart';
import '../../../Util/Utils.dart';
import '../../../Widgets/HistoryWidget.dart';

class YesterdayTab extends StatefulWidget {
  YesterdayTab({Key? key}) : super(key: key);

  @override
  State<YesterdayTab> createState() => _YesterdayTabState();
}

class _YesterdayTabState extends State<YesterdayTab>
    implements YesterdayTabView {
  bool _customTileExpanded = false;

  List<HistoryData> _history = [];

  bool isOffline = false;
  bool isLoading = false;
  bool isInit = false;
  late YesterdayTabPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  String searchText = '';

  _YesterdayTabState() {
    _presenter = YesterdayTabPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Card(
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                onChanged: (value) {
                  searchText = value;
                  if (mounted) setState(() {});
                },
                style: const TextStyle(fontSize: 25),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    contentPadding: EdgeInsets.zero,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: Strings.SEARCH_VEHICLE_MOBILE,
                    hintStyle: const TextStyle(fontSize: 18)),
              ),
            ),
          ),
          buildListView(),
        ],
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
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void setHistoryData(List<HistoryData> data) {
    // TODO: implement setHistoryData
    _history = data;
    if (mounted) setState(() {});
  }

  Widget buildListView() {
    List<HistoryData> data = getHistoryData();
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) => HistoryWidget(_history[index])),
    );
  }

  List<HistoryData> getHistoryData() {
    if (searchText != null && searchText != "") {
      return _history
          .where((element) => element
              .toSearchString()!
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    } else {
      return _history;
    }
  }
}
