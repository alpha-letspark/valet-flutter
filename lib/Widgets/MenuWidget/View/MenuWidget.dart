import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:valet_app/ConnectivityStatusSingleton.dart';
import 'package:valet_app/HistoryScreen/View/HistoryScreen.dart';
import 'package:valet_app/ParkingInfoScreen/View/ParkingInfoScreen.dart';

import 'package:valet_app/SettingScreen/View/SettingScreen.dart';
import 'package:valet_app/LoginScreen/View/LoginScreen.dart';
import 'package:valet_app/SummaryScreen/view/SummaryScreen.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/MenuWidget/Presenter/MenuWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/MenuWidget/View/MenuWidgetView.dart';

import '../../../Util/Utils.dart';
import '../../AppBarWidget/View/AppBarWidget.dart';

class MenuScreen extends StatefulWidget {
  static const String routeName = "MenuScreen";
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> implements MenuWidgetView {
  bool isOffline = false;
  bool isLoading = false;

  bool isHistory = false;
  bool isParked = false;
  bool isSetting = false;
  int count = 0;
  String version = '';

  late MenuWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  _MenuScreenState() {
    _presenter = MenuWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    checkVersion();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _presenter.getUploadPhotoCount());
  }

  void checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Version : $version"),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBarWidget(onNewEntryClick, onRefreshClick, () {}),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black12),
                        ),
                      ),
                      child: Visibility(
                        visible: count != 0,
                        child: ListTile(
                            onTap: () {
                              _presenter.uploadDocument();
                            },
                            title: const Text("Upload Photo"),
                            trailing: Text(
                              count.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            )),
                      )),
                  Visibility(
                    visible: isHistory,
                    child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: ListTile(
                            onTap: () {
                              onHistoryClick();
                            },
                            title: const Text(Strings.HISTORY),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                onHistoryClick();
                              },
                            ))),
                  ),
                  Visibility(
                    visible: isSetting,
                    child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: ListTile(
                            onTap: () {
                              onSettingClick();
                            },
                            title: const Text(Strings.SETTING),
                            trailing: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                onSettingClick();
                              },
                            ))),
                  ),
                  Visibility(
                    visible: isParked,
                    child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: ListTile(
                          title: const Text(Strings.SUMMARY),
                          onTap: () {
                            onSummaryClicked();
                          },
                        )),
                  ),
                  Visibility(
                    visible: isParked,
                    child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: ListTile(
                          title: const Text(Strings.PARKED_INFO),
                          onTap: () {
                            onParkingInfoClick();
                          },
                        )),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black12),
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          onLogoutsClick();
                        },
                        title: const Text(Strings.LOGOUT),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void setPermission(bool isHistory, bool isSetting, bool isParked) {
    this.isHistory = isHistory;
    this.isSetting = isSetting;
    this.isParked = isParked;
    setState(() {});
  }

  void onHistoryClick() {
    Navigator.of(context)
        .pushNamed(HistoryScreen.routeName)
        .then((value) => handleNewEntryClick(value));
  }

  void onSettingClick() {
    Navigator.of(context)
        .pushNamed(SettingScreen.routeName)
        .then((value) => handleNewEntryClick(value));
  }

  void onParkingInfoClick() {
    Navigator.of(context)
        .pushNamed(ParkingInfoScreen.routeName)
        .then((value) => handleNewEntryClick(value));
  }

  void onLogoutsClick() {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void onNewEntryClick() {
    Navigator.of(context).pop(true);
  }

  void onRefreshClick() {}

  handleNewEntryClick(value) {
    if (value != null && value) {
      onNewEntryClick();
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
  void showUploadPhotoCount(int count) {
    // TODO: implement showUploadPhotoCount
    this.count = count;
    setState(() {});
  }

  void onSummaryClicked() {
    Navigator.of(context)
        .pushNamed(SummaryScreen.routeName)
        .then((value) => handleNewEntryClick(value));
  }
}
