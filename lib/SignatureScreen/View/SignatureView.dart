import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureView extends StatefulWidget {
  static String routeName = 'SignatureView';
  SignatureView({Key? key}) : super(key: key);

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

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

    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) {
    //       return Scaffold(
    //         appBar: AppBar(),
    //         body: Center(
    //           child: Container(
    //             color: Colors.grey[300],
    //             child: Image.memory(bytes!.buffer.asUint8List()),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            children: [
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Html(data: ""),
              )),
          Expanded(
            flex: 4,
            child: Container(
                child: SfSignaturePad(
                    key: signatureGlobalKey,
                    backgroundColor: Colors.white,
                    strokeColor: Colors.black,
                    minimumStrokeWidth: 1.0,
                    maximumStrokeWidth: 4.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey))),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: _handleSaveButtonPressed,
              ),
              // TextButton(
              //   child: Text('Clear'),
              //   onPressed: _handleClearButtonPressed,
              // )
            ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
          )
        ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center));
  }
}
