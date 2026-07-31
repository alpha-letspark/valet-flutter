import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:valet_app/Database/DatabaseProvider.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/SignatureScreen/View/SignatureScreen.dart';

import 'package:valet_app/Data/theme_Data.dart';
import 'package:valet_app/HistoryScreen/View/HistoryScreen.dart';
import 'package:valet_app/HomeScreen/View/HomeScreen.dart';
import 'package:valet_app/ParkingInfoScreen/View/ParkingInfoScreen.dart';
import 'package:valet_app/LoginScreen/View/LoginScreen.dart';
import 'package:valet_app/SummaryScreen/view/SummaryScreen.dart';
import 'package:valet_app/Util/Utils.dart';
import 'package:valet_app/Widgets/MenuWidget/View/MenuWidget.dart';

import 'package:valet_app/SettingScreen/View/SettingScreen.dart';

import 'ConnectivityStatusSingleton.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initializeNew();

  await DatabaseProvider.get.db();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");
  bool isFromNotification = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handleOneSignalData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LP Valet App',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      navigatorKey: navigatorKey,
      theme: basicTheme(),
      initialRoute: LoginScreen.routeName,
      routes: <String, WidgetBuilder>{
        LoginScreen.routeName: (context) => LoginScreen(),
        //CheckOutTab.routeName: (context) => CheckOutTab(),
        //CheckInTab.routeName: (context) => CheckInTab(),
        HomeScreenNew.routeName: (context) => HomeScreenNew(),
        MenuScreen.routeName: ((context) => MenuScreen()),
        SettingScreen.routeName: (context) => SettingScreen(),
        ParkingInfoScreen.routeName: (context) => ParkingInfoScreen(),
        HistoryScreen.routeName: (context) => HistoryScreen(),
        SignatureScreen.routeName: (context) => SignatureScreen(),
        SummaryScreen.routeName: (context) => SummaryScreen(),
      },
    );
  }

  void handleOneSignalData() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    //OneSignal.initialize("43309152-c9d5-44d0-bb7a-94f566105564"); ravi
    //OneSignal.initialize("1624bd34-5344-453e-83dc-1f7daa9d13da"); //kanisha
    OneSignal.initialize("9099585a-a6be-4be9-942b-8ff4d2dc970c"); //DOC
    OneSignal.Notifications.requestPermission(true);

    OneSignal.Notifications.addClickListener((event) async {
      bool canPop = Navigator.of(navigatorKey.currentState!.context).canPop();
      if (!canPop) {
        await Preferences.setBoolValue(Preferences.IS_NOTIFICATION, true);
      } else {
        navigatorKey.currentState
            ?.pushNamed(HomeScreenNew.routeName, arguments: true);
      }
    });
  }
}
