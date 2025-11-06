import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/SettingData.dart';
import 'package:valet_app/SettingScreen/Presenter/SettingScreenPresenterImpl.dart';
import 'package:valet_app/SettingScreen/View/SettingScreenView.dart';
import 'package:valet_app/Util/Strings.dart';

import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidget.dart';

import '../../ConnectivityStatusSingleton.dart';
import '../../Util/Utils.dart';

class SettingScreen extends StatefulWidget {
  static const String routeName = 'SettingScreen';
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    implements SettingScreenView {
  bool guestRequest = false;
  bool etaPermission = false;
  bool searchSugget = false;

  bool isLoading = false;
  bool isOffline = false;

  late SettingScreenPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  _SettingScreenState() {
    _presenter = SettingScreenPresenterImpl();
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarWidget(
              onNewEntryClicked,
              onRefreshClicked,
              onMenuClicked,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black26),
                        ),
                      ),
                      child: const ListTile(
                        title: Text(
                          Strings.SETTING,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      )),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black12),
                        ),
                      ),
                      child: ListTile(
                        title: const Text(Strings.GUEST_REQUEST_PERMISSION),
                        trailing: Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
                            value: guestRequest,
                            onChanged: (value) => setState(() {
                                  guestRequest = value;
                                })),
                      )),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black12),
                        ),
                      ),
                      child: ListTile(
                        title: const Text(Strings.ETA_PERMISSION),
                        trailing: Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
                            value: etaPermission,
                            onChanged: (value1) => setState(() {
                                  etaPermission = value1;
                                })),
                      )),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black12),
                        ),
                      ),
                      child: ListTile(
                        title: const Text(Strings.SEARCH_SUGGESTION),
                        trailing: Switch.adaptive(
                            activeColor: Theme.of(context).primaryColor,
                            value: searchSugget,
                            onChanged: (value3) => setState(() {
                                  searchSugget = value3;
                                })),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                onSubmitClick();
                              },
                              child: const Text("Submit")))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onMenuClicked() {
    Navigator.of(context).pop();
  }

  void onNewEntryClicked() {
    Navigator.of(context).pop(true);
  }

  void onRefreshClicked() {
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
    Utils.showToastMsg(msg ?? "",
        textColor: Colors.black, backgroundColor: Colors.white);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  void setSettingData(SettingData? data) {
    // TODO: implement setSettingData
    if (data != null) {
      guestRequest = data.guest_req == 1;
      etaPermission = data.eta_extend == 1;
      searchSugget = data.search_suggest == 1;
      if (mounted) setState(() {});
    }
  }

  void onSubmitClick() {
    _presenter.onSubmitClick(guestRequest, etaPermission, searchSugget);
  }
}
