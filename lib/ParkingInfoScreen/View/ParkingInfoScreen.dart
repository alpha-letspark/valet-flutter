import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidget.dart';

import '../../Widgets/ParkedInfoWidget/View/ParkedInfoWidget.dart';

class ParkingInfoScreen extends StatefulWidget {
  static const String routeName = 'ParkingInfoScreen';
  ParkingInfoScreen({Key? key}) : super(key: key);

  @override
  State<ParkingInfoScreen> createState() => _ParkingInfoScreenState();
}

class _ParkingInfoScreenState extends State<ParkingInfoScreen> {
  bool isMenuClick = false;
  bool isParkingInfoClick = true;
  bool isNewEntryClick = false;
  bool isCheckInOutVisible = false;
  bool isCheckInClick = false;
  bool isCheckOutClick = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            AppBarWidget(
              onNewEntryClick,
              onRefreshClick,
              onMenuClicked,
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.black26),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  Strings.PARKED_INFO,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: ParkingInfoWidget(onTranscationUpdated))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onMenuClicked() {
    Navigator.of(context).pop();
  }

  void onNewEntryClick() {
    Navigator.of(context).pop(true);
  }

  void onRefreshClick() {}

  void onTranscationUpdated() {}
}
