import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Utils {
  static bool isNotification = false;
  static const Color orangeColor = Color(0xFFF26424);
  static showToastMsg(String msg,
      {Color textColor: Colors.white, Color backgroundColor: orangeColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  static Future<String> getPhotoPath() async {
    final appExDir = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : await getExternalStorageDirectory();
    String appExPath = appExDir!.path;
    return join(
        appExPath, DateTime.now().millisecondsSinceEpoch.toString() + ".jpg");
  }
}
