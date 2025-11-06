import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:valet_app/Data/ExitPinPassArg.dart';
import 'package:valet_app/Data/Response/ExitListData.dart';
import 'package:valet_app/Dialog/ExitConfirmDialog/View/ExitConfirmDialog.dart';
import 'package:valet_app/Dialog/PopUpExitDialog/View/PopUpExitDialog.dart';
import 'package:valet_app/Widgets/ExitListWidget/Presenter/ExitListWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/ExitListWidget/View/ExitListWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/Response/DriverListData.dart';

import '../../../Dialog/NetworkImageDialog.dart';
import '../../../Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import '../../../Util/Strings.dart';
import '../../../Util/Utils.dart';

class ExitListWidget extends StatefulWidget {
  ExitListData data;
  bool isDriver;
  Function onTranscationSuccessful;
  ExitListWidget(this.data, this.isDriver, this.onTranscationSuccessful,
      {Key? key})
      : super(key: key);

  @override
  State<ExitListWidget> createState() => _ExitListWidgetState();
}

class _ExitListWidgetState extends State<ExitListWidget>
    implements ExitListWidgetView {
  bool _customTileExpanded = false;
  bool isOffline = false;
  bool isLoading = false;

  List<String> visibleFieldList = [];
  List<String> mandetoryFieldList = [];

  late ExitListWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  TextEditingController valetDriverController = TextEditingController();

  DriverListData? driverListData;
  List<String> thumbnailImages = [];
  List<String> vehicleImages = [];

  _ExitListWidgetState() {
    _presenter = ExitListWidgetPresenterImpl();
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
    _presenter.initData(widget.data);
    valetDriverController.text = widget.data.picked_by ?? "";
    thumbnailImages = widget.data.thumbnail_photo ?? [];
    vehicleImages = widget.data.vehicle_photo ?? [];

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_HOOK_NUMBER),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        Strings.HOOK_NUMBER,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.data.hook_number ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.ETA,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        checkETA(widget.data.arrival_time ?? ""),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: checkETAStatus(
                            widget.data.status ?? "",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ExpansionTile(
              textColor: Colors.black,
              iconColor: Colors.black,
              collapsedTextColor: Colors.black,
              collapsedIconColor: Colors.black,
              trailing: _customTileExpanded
                  ? const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                    )
                  : const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      size: 30,
                    ),
              tilePadding: const EdgeInsets.symmetric(horizontal: 5),
              title: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.VEHICLE_NUMBER,
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.data.vehicle_number ?? "",
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.data.vehicle_type ?? "",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              children: [
                const Divider(
                  thickness: 1,
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VEHICLE_NAME),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.VEHICLE_NAME,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.vehicle_name ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VEHICLE_NAME),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible:
                      visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.VEHICLE_COLOR,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.vehicle_color ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.DATE_TIME,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.data.entry_time ?? "",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_GUEST_NAME),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.GUEST_NAME,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.guest_name ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_GUEST_NAME),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_GUEST_MOBILE),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.GUEST_NUMBER,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.guest_mobile ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_GUEST_MOBILE),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.Parked_By,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.parked_by ?? "",
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VALUABLE),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.ANYTHING_VALUABLE,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: widget.data.valuable == "1",
                            child: Text(
                              widget.data.valuable_things ?? '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_VALUABLE),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.ADD_PHOTOS,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              thumbnailImages.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        String img = vehicleImages.isNotEmpty
                                            ? vehicleImages[0]
                                            : thumbnailImages[0];
                                        showPhoto(img);
                                      },
                                      child: Image.network((thumbnailImages[0]),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: const Icon(
                                        Icons.directions_car,
                                        color: Colors.black54,
                                      ),
                                    ),
                              thumbnailImages.length >= 2
                                  ? InkWell(
                                      onTap: () {
                                        String img = vehicleImages.length >= 2
                                            ? vehicleImages[1]
                                            : thumbnailImages[1];
                                        showPhoto(img);
                                      },
                                      child: Image.network((thumbnailImages[1]),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: const Icon(
                                        Icons.directions_car,
                                        color: Colors.black54,
                                      ),
                                    ),
                              thumbnailImages.length >= 3
                                  ? InkWell(
                                      onTap: () {
                                        String img = vehicleImages.length >= 3
                                            ? vehicleImages[2]
                                            : thumbnailImages[2];
                                        showPhoto(img);
                                      },
                                      child: Image.network((thumbnailImages[2]),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: const Icon(
                                        Icons.directions_car,
                                        color: Colors.black54,
                                      ),
                                    ),
                              thumbnailImages.length >= 4
                                  ? InkWell(
                                      onTap: () {
                                        String img = vehicleImages.length >= 4
                                            ? vehicleImages[3]
                                            : thumbnailImages[3];
                                        showPhoto(img);
                                      },
                                      child: Image.network((thumbnailImages[3]),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: const Icon(
                                        Icons.directions_car,
                                        color: Colors.black54,
                                      ),
                                    ),
                              thumbnailImages.length >= 5
                                  ? InkWell(
                                      onTap: () {
                                        String img = vehicleImages.length >= 5
                                            ? vehicleImages[4]
                                            : thumbnailImages[4];
                                        showPhoto(img);
                                      },
                                      child: Image.network((thumbnailImages[4]),
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                        return const SizedBox();
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
                                      ),
                                      child: const Icon(
                                        Icons.directions_car,
                                        color: Colors.black54,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                  child: const Divider(
                    thickness: 1,
                  ),
                ),
                Visibility(
                  visible: visibleFieldList.contains(Strings.MAND_NOTE),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.NOTES,
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.data.notes ?? '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              onExpansionChanged: (bool expanded) {
                if (mounted) setState(() => _customTileExpanded = expanded);
              },
            ),
            Visibility(
              visible: widget.isDriver,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        Strings.PICKED_UP_By,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onTap: () {
                            _presenter.getDriverList();
                          },
                          showCursor: false,
                          readOnly: true,
                          controller: valetDriverController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            hintText: Strings.UNASSIGNED,
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
              child: const Divider(
                thickness: 1,
              ),
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_PARKING_LOT),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        Strings.LOCATION,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.data.location ?? '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_PARKING_LOT),
              child: const Divider(
                thickness: 1,
              ),
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_SLOTS),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        Strings.SLOTS,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.data.slots ?? '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_SLOTS),
              child: const Divider(
                thickness: 1,
              ),
            ),
            // Visibility(
            //   visible: visibleFieldList.contains(Strings.MAND_HOOK_NUMBER),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 5),
            //     child: Row(
            //       children: [
            //         const Expanded(
            //           child: Text(
            //             Strings.HOOK_NUMBER,
            //             style: TextStyle(
            //                 color: Colors.black54,
            //                 fontSize: 15,
            //                 fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //         Expanded(
            //           child: Text(
            //             widget.data.hook_number ?? '',
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Row(
              children: [
                Expanded(
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    )),
                    child: Text(
                      Strings.EXIT_MANUALLY,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      _presenter.onExitManuallyClicked(widget.data);
                    },
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    )),
                    child: Text(
                      Strings.EXIT,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      _presenter.onSubmitClick(widget.data);
                    },
                    fillColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  DriverListData? getDriverData() {
    return driverListData;
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
      ).then((value) => isLoading = false);
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
  void setDriverListResponse(List<DriverListData> data) {
    // TODO: implement setParkingLocationResponse
    showDialog(context: context, builder: (context) => SelectDriverDialog(data))
        .then((value) => handleDriverListClick(value));
  }

  void handleDriverListClick(value) {
    if (value != null) {
      driverListData = value;
      valetDriverController.text = (driverListData?.name ?? '');
    }
  }

  @override
  void setVisibleFieldList(List<String> visible) {
    // TODO: implement setVisibleFieldList
    visibleFieldList = visible;
  }

  @override
  void setMandatoryFieldList(List<String> mandatory) {
    // TODO: implement setMandatoryFieldList
    mandetoryFieldList = mandatory;

    if (mounted) setState(() {});
  }

  @override
  void onTranscationSuccess() {
    widget.onTranscationSuccessful();
  }

  Widget checkETAStatus(String status) {
    if (status.toLowerCase() == "Accepted".toLowerCase()) {
      return InkWell(
        onTap: () {
          _presenter.markReady(widget.data);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              border: Border.all(color: Theme.of(context).primaryColorDark)),
          child: const Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "Ready",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
      );
    } else if (status.toLowerCase() == "READY".toLowerCase() ||
        status.toLowerCase() == "ROLLBACK".toLowerCase()) {
      return InkWell(
        onTap: () {
          showConfirmationDialog();
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400],
              border: Border.all(color: Colors.black54)),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              "RollBack",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  void showConfirmationDialog() {
    showDialog(context: context, builder: (context) => ExitConfirmDialog())
        .then((value) => handleConfirmationValue(value));
  }

  Widget checkETA(String s) {
    DateTime? dt = DateTime.tryParse(s);
    if (dt == null) {
      return const Expanded(child: SizedBox());
    }
    if (dt.compareTo(DateTime.now()) == -1 ||
        dt.compareTo(DateTime.now()) == 0) {
      return const Expanded(child: SizedBox());
    }

    return CountdownTimer(
      endTime: dt.millisecondsSinceEpoch,
      widgetBuilder: (_, time) {
        if (time == null) {
          return const Text(
            '00:00 mins',
            style: TextStyle(color: Colors.black, fontSize: 15),
          );
        }
        return Text(
          '${time.min ?? "00".padLeft(2, "0")}:${time.sec ?? "00".padLeft(2, "0")} mins',
          style: const TextStyle(color: Colors.black, fontSize: 15),
        );
      },
    );
  }

  @override
  void showPinDialog(ExitListData data, String masterKey, bool shouldShowPin) {
    // TODO: implement showPinDialog

    showDialog(
        context: context,
        builder: (context) => PopUpExitDialog(
            data.vehicle_number ?? "",
            data.hook_number ?? "",
            masterKey == "1",
            shouldShowPin)).then((value) => handlePinPassValue(data, value));
  }

  void handlePinPassValue(ExitListData data, value) {
    if (value != null && value is ExitPinPassArg) {
      String pin = value.pin ?? '';
      String password = value.password ?? '';
      _presenter.exitTranscation(data, pinNo: pin, password: password);
    }
  }

  void handleConfirmationValue(value) {
    if (value != null && value) {
      _presenter.markRollback(widget.data);
    }
  }

  void showPhoto(String image) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
            scale: curve,
            child: image != "" ? NetworkImageDialog(image) : const SizedBox());
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
