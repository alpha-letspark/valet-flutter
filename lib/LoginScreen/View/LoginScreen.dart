import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:valet_app/Data/Request/LoginRequest.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/HomeScreen/View/HomeScreen.dart';
import 'package:valet_app/LoginScreen/Presenter/LoginScreenPresenterImpl.dart';
import 'package:valet_app/LoginScreen/View/LoginScreenView.dart';
import 'package:valet_app/Util/Strings.dart';

import '../../ConnectivityStatusSingleton.dart';
import '../../Preferences/preferences.dart';
import '../../Util/Utils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginScreenView {
  late LoginScreenPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isOffline = false;
  String version = '';
  bool isVisible = false;
  _LoginScreenState() {
    _presenter = LoginScreenPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();

    userNameController.text = 'Wmvalet';
    passwordController.text = "windmills@123";
    checkVersion();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());
  }

  void checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/LetsPark.png"),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                  controller: userNameController,
                  cursorColor: Theme.of(context).primaryColorDark,
                  decoration: InputDecoration(
                    floatingLabelStyle:
                        const TextStyle(fontSize: 20, color: Colors.black38),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark, width: 2),
                    ),
                    labelText: Strings.USER_NAME,
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: TextField(
                obscureText: !isVisible,
                controller: passwordController,
                cursorColor: Theme.of(context).primaryColorDark,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        isVisible ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                    floatingLabelStyle:
                        const TextStyle(fontSize: 20, color: Colors.black38),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    labelText: Strings.PASSWORD,
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                    )),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Theme.of(context).primaryColorDark,
                          width: 1.0,
                        ),
                      ),
                      child: TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorDark,
                          )),
                          onPressed: () {
                            onSubmitClick();
                          },
                          child: Text(
                            Strings.SUBMIT,
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Version : $version"),
          ),
        ],
      ),
    );
  }

  void onSubmitClick() {
    String userName = userNameController.text;
    String password = passwordController.text;
    if (userName == '' || password == '') {
      showErrorMsg("Please enter username and password");
      return;
    }
    LoginRequest request = LoginRequest();

    request.username = userName;
    request.password = password;

    _presenter.onLoginClick(request);
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
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void onLoginSuccess(LoginResponse response) async {
    // TODO: implement onLoginSuccess

    bool? isFromNotification =
        await Preferences.getBoolValue(Preferences.IS_NOTIFICATION);
    await Preferences.setBoolValue(Preferences.IS_NOTIFICATION, false);

    Navigator.of(context)
        .pushNamed(HomeScreenNew.routeName, arguments: isFromNotification);
  }

  @override
  void askPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isPermanentlyDenied) {
      showErrorMsg("Please allow camera permission from setting");
    } else if (status.isDenied) {
      askPermission();
      return;
    }
    bool isOpt = await OneSignal.Notifications.requestPermission(true);
    if (isOpt) {
      OneSignal.User.pushSubscription.optIn();
    } else {
      OneSignal.User.pushSubscription.optOut();
    }
    _presenter.getPlayerId();
  }
}
