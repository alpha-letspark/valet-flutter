import 'package:flutter/material.dart';
import 'package:valet_app/ConnectivityStatusSingleton.dart';
import 'package:valet_app/Data/Response/UnparkedListData.dart';

import 'package:valet_app/Widgets/UnParkedListWidget/View/UnParkedListWidget.dart';
import 'package:valet_app/fragment/UnParkedTab/Presenter/UnParkedTabPresenterImpl.dart';
import 'package:valet_app/fragment/UnParkedTab/View/UnParkedTabView.dart';

import '../../../Util/Strings.dart';
import '../../../Util/Utils.dart';

class UnParkedTab extends StatefulWidget {
  Function onTranscationUpdated;
  UnParkedTab(this.onTranscationUpdated, {Key? key}) : super(key: key);

  // @override
  // State<UnParkedTab> createState() => _UnParkedTabState();

  var state = _UnParkedTabState();

  @override
  _UnParkedTabState createState() {
    return state = new _UnParkedTabState();
  }

  void refresh() => state.refresh();
}

class _UnParkedTabState extends State<UnParkedTab> implements UnParkedTabview {
  bool isCheckInClick = false;
  bool isCheckOutClick = false;
  bool isNewEntryClick = true;
  bool isMenuClick = false;
  bool isCheckInOutClick = true;

  bool isOffline = false;
  bool isLoading = false;
  bool isInit = false;
  late UnParkedTabPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;
  List<UnparkedListData> unparkedData = [];
  String searchText = '';

  _UnParkedTabState() {
    _presenter = UnParkedTabPresenterImpl();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
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
                  onChanged: ((value) {
                    searchText = value;
                    if (mounted) setState(() {});
                  }),
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
                      hintText: Strings.SEARCH_VEHICLE_HOOK,
                      hintStyle: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            buildListView(),
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    List<UnparkedListData> dataList = getUnparkedVehicle();
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length,
          itemBuilder: (context, index) =>
              UnParkedListWidget(dataList[index], onTranscationSuccessful)),
    );
  }

  void onTranscationSuccessful() {
    widget.onTranscationUpdated();
    _presenter.initData();
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
      if (mounted)
        setState(() {
          isLoading = false;
        });
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
  void setUnparekedListItem(List<UnparkedListData> data) {
    // TODO: implement setUnparekedListItem
    unparkedData = data;
    if (mounted) setState(() {});
  }

  List<UnparkedListData> getUnparkedVehicle() {
    if (searchText != null && searchText != '') {
      return unparkedData
          .where((element) => element
              .toSearchString()
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }
    return unparkedData;
  }

  void refresh() {
    _presenter.initData();
  }
}
