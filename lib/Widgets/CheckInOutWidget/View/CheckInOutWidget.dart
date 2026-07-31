import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/EntryMenuNumberResponse.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/CheckInOutWidget/Presenter/CheckInOutWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/CheckInOutWidget/View/CheckInOutWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Util/Utils.dart';

class CheckInOut extends StatefulWidget {
  Function handleOnClick;

  CheckInOut(this.handleOnClick, {Key? key}) : super(key: key);

  // _CheckInOutState state = _CheckInOutState();
  // @override
  // State<CheckInOut> createState() => state;

  var state = _CheckInOutState();

  @override
  _CheckInOutState createState() {
    return state = new _CheckInOutState();
  }

  void refreshCount() => state.initData();

  void clearSelection() => state.clearSelection();
}

class _CheckInOutState extends State<CheckInOut>
    implements CheckInOutWidgetView {
  bool isCheckInClicked = false;
  bool isCheckOutClicked = false;

  bool isOffline = false;
  bool isLoading = false;
  late CheckInOutWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  String checkOutCount = "";
  String checkInCount = "";
  String totalRequstCount = "";
  String totalExitCount = "";

  bool isCheckIn = false;
  bool isCheckOut = false;

  _CheckInOutState() {
    _presenter = CheckInOutWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();

    WidgetsBinding.instance!.addPostFrameCallback((_) => initData());
  }

  void initData() {
    _presenter.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Visibility(
            visible: isCheckIn,
            child: Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: isCheckInClicked
                        ? MaterialStateProperty.all(
                            Theme.of(context).primaryColor)
                        : MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black26),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.CHECK_IN,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isCheckInClicked
                              ? Colors.white
                              : Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: checkInCount == ""
                          ? const BoxDecoration()
                          : BoxDecoration(
                              color: isCheckInClicked
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          checkInCount,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isCheckInClicked
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      isCheckInClicked = true;
                      isCheckOutClicked = false;
                      widget.handleOnClick(1, null, null);
                      // Navigator.of(context).pushNamed(CheckInTab.routeName);
                    });
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: isCheckOut,
            child: Expanded(
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: isCheckOutClicked
                        ? MaterialStateProperty.all(
                            Theme.of(context).primaryColorDark)
                        : MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black26),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.CHECK_OUT,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isCheckOutClicked
                              ? Colors.white
                              : Theme.of(context).primaryColorDark),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: checkOutCount == ""
                          ? const BoxDecoration()
                          : BoxDecoration(
                              color: isCheckOutClicked
                                  ? Colors.white
                                  : Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(2),
                            ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          checkOutCount,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isCheckOutClicked
                                  ? Theme.of(context).primaryColorDark
                                  : Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      isCheckOutClicked = true;
                      isCheckInClicked = false;
                      widget.handleOnClick(2, totalRequstCount, totalExitCount);
                      //Navigator.of(context).pushNamed(CheckOutTab.routeName);
                    });
                  }
                },
              ),
            ),
          ),
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
  void setMenuNumberResponse(EntryMenuNumberResponse response) {
    // TODO: implement setMenuNumberResponse
    checkInCount = int.parse(response.total_checkin ?? "0") == 0
        ? ""
        : response.total_checkin.toString();
    checkOutCount = int.parse(response.total_checkout ?? "0") == 0
        ? ""
        : response.total_checkout.toString();
    totalRequstCount = int.parse(response.total_request ?? "0") == 0
        ? ""
        : response.total_checkout.toString();
    totalExitCount = int.parse(response.total_exit ?? "0") == 0
        ? ""
        : response.total_exit.toString();
    if (isCheckOutClicked) {
      widget.handleOnClick(2, totalRequstCount, totalExitCount);
    }
    if (mounted) setState(() {});
  }

  void onRefreshClick() {
    _presenter.initData();
  }

  clearSelection() {
    isCheckInClicked = false;
    isCheckOutClicked = false;
    setState(() {});
  }

  @override
  void setPermissions(bool isCheckIn, bool isCheckOut) {
    this.isCheckIn = isCheckIn;
    this.isCheckOut = isCheckOut;
    setState(() {});
  }
}
