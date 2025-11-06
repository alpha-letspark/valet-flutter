import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:valet_app/Data/Response/SignatureData.dart';
import 'package:valet_app/SignatureScreen/Presenter/SignatureScreenPresenterImpl.dart';
import 'package:valet_app/SignatureScreen/View/SignatureScreenView.dart';
import 'package:valet_app/Util/Strings.dart';
import 'dart:ui' as ui;

import '../../ConnectivityStatusSingleton.dart';
import '../../Util/Utils.dart';

class SignatureScreen extends StatefulWidget {
  static const String routeName = 'SignatureScreen';
  SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen>
    implements SignatureScreenView {
  bool isLoading = false;
  bool isOffline = false;
  String htmlText = "";

  late SignatureScreenPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  _SignatureScreenState() {
    _presenter = SignatureScreenPresenterImpl();
    _presenter.attachView(this);
  }

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);

    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    if (bytes != null) {
      final Uint8List imageBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      final appExDir = Platform.isIOS
          ? await getApplicationDocumentsDirectory()
          : await getExternalStorageDirectory();
      String appExPath = appExDir!.path;
      String targetpath =
          "$appExPath/ ${DateTime.now().millisecondsSinceEpoch.toString()}.png";

      final File file = File(targetpath);
      await file.writeAsBytes(imageBytes, flush: true);
      Navigator.of(context).pop(file);
    }
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
      padding: const EdgeInsets.all(10.0),
      child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 6,
                child: SingleChildScrollView(child: Html(data: htmlText))),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                      child: SfSignaturePad(
                          key: signatureGlobalKey,
                          backgroundColor: Colors.white,
                          strokeColor: Colors.black,
                          minimumStrokeWidth: 1.0,
                          maximumStrokeWidth: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey))),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        signatureGlobalKey.currentState?.clear();
                      },
                      child: const Text("Clear"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Row(children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Save'),
                    onPressed: _handleSaveButtonPressed,
                  ),
                ),
              ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center),
    ));
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
  void setSignatureData(SignatureData? data) {
    // TODO: implement setSignatureData
    if (data != null) {
      htmlText = data.signature_tc ?? "";
      if (mounted) setState(() {});
    }
  }
}
