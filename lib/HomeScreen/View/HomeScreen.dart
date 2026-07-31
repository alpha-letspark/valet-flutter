import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:valet_app/Data/Response/InputFieldResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/HomeScreen/Presenter/HomeScreenPresenterImpl.dart';
import 'package:valet_app/HomeScreen/View/HomeScreenView.dart';
import 'package:valet_app/LoginScreen/View/LoginScreen.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Widgets/CheckInOutWidget/View/CheckInOutWidget.dart';
import 'package:valet_app/fragment/CheckInTab/View/CheckInTab.dart';
import 'package:valet_app/fragment/CheckOutTab/View/CheckOutTab.dart';
import 'package:valet_app/Widgets/NewVehicleEntry/View/NewVehicleEntryWidget.dart';
import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidget.dart';
import 'package:valet_app/Widgets/MenuWidget/View/MenuWidget.dart';

import '../../ConnectivityStatusSingleton.dart';
import '../../Data/Response/EntryMenuNumberResponse.dart';
import '../../Util/Strings.dart';
import '../../Util/Utils.dart';

class HomeScreenNew extends StatefulWidget {
  static const String routeName = "HomeScreenNew";
  HomeScreenNew({Key? key}) : super(key: key);

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew>
    implements HomeScreenView {
  bool isCheckInClick = false;
  bool isCheckOutClick = false;
  bool isNewEntryClick = true;
  bool isMenuClick = false;
  bool isCheckInOutClick = true;

  bool isOffline = false;
  bool isLoading = false;
  bool isInit = false;
  late HomeScreenPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  InputFieldResponse? inputFieldResponse;
  CheckInOut? checkInOutWidget;
  NewVehicleEntry? newVehicleEntryWidget;
  CheckInTab? checkInTabWidget;
  CheckOutTab? checkOutTabWidget;

  bool isNewEntry = false;
  bool isCheckIn = false;
  bool isCheckOut = false;

  _HomeScreenNewState() {
    _presenter = HomeScreenPresenterImpl();
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
    checkInOutWidget ??= CheckInOut(
      handleCheckInOutClick,
    );
    newVehicleEntryWidget ??= NewVehicleEntry(onVehicleAdded);
    checkInTabWidget ??= CheckInTab(onTranscationSuccessFul);
    checkOutTabWidget ??= CheckOutTab(onTranscationSuccessFul);
    if (!isInit) {
      isInit = true;
      bool? isFromNotification =
          ModalRoute.of(context)?.settings.arguments as bool;
      if (isFromNotification) {
        isNewEntryClick = false;
        isCheckOutClick = true;
      }
    }
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          AppBarWidget(onNewEntryClick, onRefreshClick, onMenuClicked),
          Visibility(visible: isCheckInOutClick, child: checkInOutWidget!),
          Visibility(
              visible: isNewEntryClick && isNewEntry,
              child: Expanded(child: newVehicleEntryWidget!)),
          Visibility(
              visible: isCheckInClick && isCheckIn,
              child: Expanded(child: checkInTabWidget!)),
          Visibility(
              visible: isCheckOutClick && isCheckOut,
              child: Expanded(child: checkOutTabWidget!)),
        ],
      ),
    ));
  }

  void onMenuClicked() {
    Navigator.of(context)
        .pushNamed(MenuScreen.routeName)
        .then((value) => handleMenuPop(value));
  }

  @override
  void setPermissions(bool isNewEntry, bool isCheckIn, bool isCheckOut) {
    this.isNewEntry = isNewEntry;
    this.isCheckIn = isCheckIn;
    this.isCheckOut = isCheckOut;
    setState(() {});
  }

  void handleMenuPop(value) {
    if (value != null && value) {
      if (mounted) {
        setState(() {
          isNewEntryClick = true;
          isCheckOutClick = false;
          isCheckInClick = false;
          isMenuClick = false;
          isCheckInOutClick = true;
          checkInOutWidget?.clearSelection();
        });
      }
    }
  }

  void handleCheckInOutClick(
      int i, String? totalRequestCount, String? totalExitCount) {
    if (mounted) {
      setState(() {
        if (i == 1) {
          isNewEntryClick = false;
          isCheckOutClick = false;
          isCheckInClick = true;
        } else {
          isNewEntryClick = false;
          isCheckOutClick = true;
          isCheckInClick = false;
          checkOutTabWidget?.setCount(
              totalRequestCount ?? "", totalExitCount ?? "");
        }
      });
    }
  }

  void onNewEntryClick() {
    if (mounted) {
      setState(() {
        isNewEntryClick = true;
        isCheckOutClick = false;
        isCheckInClick = false;
        isMenuClick = false;
        isCheckInOutClick = true;
        checkInOutWidget?.clearSelection();
        newVehicleEntryWidget?.refresh();
        //newVehicleEntryWidget?.onVehicleAdded
      });
    }
  }

  void onRefreshClick() {
    if (isNewEntryClick) {
      newVehicleEntryWidget?.refresh();
    } else if (isCheckInClick) {
      checkInTabWidget?.refresh();
      checkInOutWidget?.refreshCount();
    } else if (isCheckInOutClick) {
      checkOutTabWidget?.refresh();
      checkInOutWidget?.refreshCount();
    }
  }

  void onVehicleAdded() {
    if (checkInOutWidget != null) {
      checkInOutWidget!.refreshCount();
    }
  }

  void onTranscationSuccessFul() {
    if (checkInOutWidget != null) {
      checkInOutWidget!.refreshCount();
    }
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
  void handleNotification() {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      /// Display Notification, preventDefault to not display
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing defaul
      event.notification.display();

      checkOutTabWidget?.refresh();
      checkInOutWidget?.refreshCount();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}
