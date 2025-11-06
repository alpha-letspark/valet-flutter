import 'dart:async';

import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/GuestRequestData.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Dialog/NetworkImageDialog.dart';
import 'package:valet_app/Widgets/GuestRequestWidget/Presenter/GuestRequestWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/GuestRequestWidget/View/GuestRequestWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/Response/DriverListData.dart';

import '../../../Dialog/ETA_Dialog/View/ETA_Dialog.dart';
import '../../../Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import '../../../Util/Strings.dart';
import '../../../Util/Utils.dart';

class GuestRequestWidget extends StatefulWidget {
  GuestRequestData data;
  bool isDriver;
  Function onTranscationSuccessful;
  GuestRequestWidget(this.data, this.isDriver, this.onTranscationSuccessful,
      {Key? key})
      : super(key: key);

  @override
  State<GuestRequestWidget> createState() => _GuestRequestWidgetState();
}

class _GuestRequestWidgetState extends State<GuestRequestWidget>
    implements GuestRequestWidgetView {
  bool _customTileExpanded = false;
  bool isOffline = false;
  bool isLoading = false;

  List<String> visibleFieldList = [];
  List<String> mandetoryFieldList = [];

  late GuestRequestWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  TextEditingController valetDriverController = TextEditingController();
  TextEditingController parkingLocationController = TextEditingController();
  DriverListData? driverListData;
  ParkingLocationData? parkingLocationData;

  List<String> thumbnailImages = [];
  List<String> vehicleImages = [];

  _GuestRequestWidgetState() {
    _presenter = GuestRequestWidgetPresenterImpl();
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
    parkingLocationController.text = widget.data.location ?? '';

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
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: visibleFieldList.contains(Strings.MAND_HOOK_NUMBER),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
              visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                            color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
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
                      Strings.ACCEPT,
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
      if (mounted)
        setState(() {
          isLoading = false;
        });
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
      _presenter.assignDriver(widget.data, driverListData!);
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

  @override
  void showEtaDialog(List<String?> etaList) {
    // TODO: implement showEtaDialog
    showDialog(context: context, builder: (context) => ETA_Dialog(etaList))
        .then((value) => _presenter.acceptRequest(value, widget.data));
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
