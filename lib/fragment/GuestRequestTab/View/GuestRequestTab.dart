import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/GuestRequestData.dart';

import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/GuestRequestWidget/View/GuestRequestWidget.dart';
import 'package:valet_app/fragment/GuestRequestTab/Presenter/GuestRequestTabPresenterImpl.dart';
import 'package:valet_app/fragment/GuestRequestTab/View/GuestRequestTabView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Util/Utils.dart';

class GuestRequestTab extends StatefulWidget {
  Function onTranscationUpdated;
  GuestRequestTab(this.onTranscationUpdated, {Key? key}) : super(key: key);

  @override
  State<GuestRequestTab> createState() => _GuestRequestTabState();
}

class _GuestRequestTabState extends State<GuestRequestTab>
    implements GuestRequestTabView {
  bool isLoading = false;
  bool isOffline = false;
  bool isDriver = false;

  List<GuestRequestData> data = [];

  late GuestRequestTabPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  TextEditingController pinController = TextEditingController();
  TextEditingController vnhController = TextEditingController();

  _GuestRequestTabState() {
    _presenter = GuestRequestTabPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _presenter.initData(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        onTextChanged(value);
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
                          hintText: Strings.SEARCH_PIN,
                          hintStyle: const TextStyle(
                              fontSize: 10, color: Colors.black)),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 25),
                      controller: vnhController,
                      onChanged: (value) {
                        onTextChanged(value);
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
                          hintText: Strings.SEARCH_VEHHICLE_MOBILE_HOOK,
                          hintStyle: const TextStyle(
                              fontSize: 10, color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) => GuestRequestWidget(
                      data[index], isDriver, onTranscationSuccessful)),
            ),
          ],
        ),
      ),
    );
  }

  void onTranscationSuccessful() {
    pinController.text = '';
    vnhController.text = '';
    widget.onTranscationUpdated();
    _presenter.initData('');
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

  void onTextChanged(String text) {
    _presenter.initData(text);
  }

  @override
  void showErrorMsg(String? msg) {
    Utils.showToastMsg(msg!,
        textColor: Colors.black, backgroundColor: Colors.white);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    vnhController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  void setGuestRequest(List<GuestRequestData> data) {
    // TODO: implement setGuestRequest
    this.data = data;
    if (mounted) setState(() {});
  }

  @override
  void showDriver(bool isDriver) {
    // TODO: implement showDriver
    this.isDriver = isDriver;
  }
}
