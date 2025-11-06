import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/ExitByHNData.dart';
import 'package:valet_app/Data/Response/VehicleTypeData.dart';
import 'package:valet_app/Util/Utils.dart';
import 'package:valet_app/Widgets/ExitByHNWidget/presenter/ExitByHNPresenterImpl.dart';
import 'package:valet_app/Widgets/ExitByHNWidget/view/ExitByHNWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/ExitPinPassArg.dart';
import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Dialog/ParkingLocationDialog/View/ParkingLocationDialog.dart';
import '../../../Dialog/PopUpExitDialog/View/PopUpExitDialog.dart';
import '../../../Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import '../../../Util/Strings.dart';

class ExitByHNWidget extends StatefulWidget {
  ExitByHNData data;
  Function onDataUpdated;
  bool isDriver;
  ExitByHNWidget(this.data, this.onDataUpdated, this.isDriver, {Key? key})
      : super(key: key);

  @override
  State<ExitByHNWidget> createState() => _ExitByHNWidgetState();
}

class _ExitByHNWidgetState extends State<ExitByHNWidget>
    implements ExitByHNWidgetView {
  bool _customTileExpanded = false;
  bool isOffline = false;
  bool isLoading = false;
  List<String> visibleFieldList = [];

  TextEditingController parkingLocationController = TextEditingController();
  TextEditingController valetDriverController = TextEditingController();

  ParkingLocationData? parkingLocationData;
  DriverListData? driverListData;

  late ExitByHNWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  _ExitByHNWidgetState() {
    _presenter = ExitByHNWidgetPresenterImpl();
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
    parkingLocationController.text = widget.data.location ?? "";
    valetDriverController.text = widget.data.parked_by ?? "";
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.HOOK_NUMBER,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
                          child: Text(widget.data.vehicle_number ?? ""),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Visibility(
                    visible:
                        visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
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
                // Visibility(
                //   visible: visibleFieldList.contains(Strings.MAND_VALUABLE),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 5),
                //     child: Row(
                //       children: [
                //         const Expanded(
                //           child: Text(
                //             Strings.ANYTHING_VALUABLE,
                //             softWrap: true,
                //             style: TextStyle(
                //                 color: Colors.black54,
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.w700),
                //           ),
                //         ),
                //         Expanded(
                //           child: Visibility(
                //             visible: widget.data.valuable == "1",
                //             child: Text(
                //               widget.data.valuable_things ?? '',
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                //   Visibility(
                //     visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 5),
                //       child: Row(
                //         children: [
                //           const Expanded(
                //             child: Text(
                //               Strings.ADD_PHOTOS,
                //               style: TextStyle(
                //                   color: Colors.black54,
                //                   fontWeight: FontWeight.w700,
                //                   fontSize: 15),
                //             ),
                //           ),
                //           Expanded(
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                //               children: [
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(3)),
                //                     border: Border.all(color: Colors.black54),
                //                   ),
                //                   child: const Icon(
                //                     Icons.directions_car,
                //                     color: Colors.black54,
                //                   ),
                //                 ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(3)),
                //                     border: Border.all(color: Colors.black54),
                //                   ),
                //                   child: const Icon(
                //                     Icons.directions_car,
                //                     color: Colors.black54,
                //                   ),
                //                 ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(3)),
                //                     border: Border.all(color: Colors.black54),
                //                   ),
                //                   child: const Icon(
                //                     Icons.directions_car,
                //                     color: Colors.black54,
                //                   ),
                //                 ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(3)),
                //                     border: Border.all(color: Colors.black54),
                //                   ),
                //                   child: const Icon(
                //                     Icons.directions_car,
                //                     color: Colors.black54,
                //                   ),
                //                 ),
                //                 Container(
                //                   decoration: BoxDecoration(
                //                     borderRadius: const BorderRadius.all(
                //                         Radius.circular(3)),
                //                     border: Border.all(color: Colors.black54),
                //                   ),
                //                   child: const Icon(
                //                     Icons.directions_car,
                //                     color: Colors.black54,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Visibility(
                //     visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                //     child: const Divider(
                //       thickness: 1,
                //     ),
                //   ),
                //   Visibility(
                //     visible: visibleFieldList.contains(Strings.MAND_NOTE),
                //     child: Padding(
                //       padding:
                //           const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                //       child: Row(
                //         children: [
                //           const Expanded(
                //             child: Text(
                //               Strings.NOTES,
                //               style: TextStyle(
                //                   color: Colors.black54,
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.w700),
                //             ),
                //           ),
                //           Expanded(
                //             child: TextField(
                //               onTap: () {
                //                 showDialog(
                //                         context: context,
                //                         builder: (context) =>
                //                             NotesDialog(notesController.text))
                //                     .then((value) => handleNotesValue(value));
                //               },
                //               readOnly: true,
                //               showCursor: false,
                //               controller: notesController,
                //               decoration: InputDecoration(
                //                 filled: true,
                //                 fillColor: Colors.white,
                //                 contentPadding:
                //                     const EdgeInsets.symmetric(horizontal: 5),
                //                 hintText: Strings.UNASSIGNED,
                //                 hintStyle: const TextStyle(fontSize: 12),
                //                 border: const OutlineInputBorder(
                //                     borderSide: BorderSide(color: Colors.black)),
                //                 focusedBorder: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                     color: Theme.of(context).primaryColor,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
              ],
              onExpansionChanged: (bool expanded) {
                if (mounted) setState(() => _customTileExpanded = expanded);
              },
            ),
            Visibility(
              visible: widget.isDriver,
              //visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
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
              visible: widget.isDriver,
              //visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
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
                      Strings.LOCATION,
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
                          _presenter.getParkingLocationList();
                        },
                        showCursor: false,
                        readOnly: true,
                        controller: parkingLocationController,
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
            const Divider(
              thickness: 1,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 5),
            //   child: Row(
            //     children: [
            //       const Expanded(
            //         child: Text(
            //           Strings.HOOK_NUMBER,
            //           style: TextStyle(
            //               color: Colors.black54,
            //               fontSize: 15,
            //               fontWeight: FontWeight.w700),
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(widget.data.hook_number ?? ""),
            //         // TextField(
            //         //   showCursor: false,
            //         //   enabled: false,
            //         //   decoration: InputDecoration(
            //         //     filled: true,
            //         //     fillColor: Colors.white,
            //         //     contentPadding:
            //         //         const EdgeInsets.symmetric(horizontal: 5),
            //         //     hintText: Strings.UNASSIGNED,
            //         //     hintStyle: const TextStyle(fontSize: 12),
            //         //     border: const OutlineInputBorder(
            //         //         borderSide: BorderSide(color: Colors.black)),
            //         //     focusedBorder: OutlineInputBorder(
            //         //       borderSide: BorderSide(
            //         //         color: Theme.of(context).primaryColor,
            //         //       ),
            //         //     ),
            //         //   ),
            //         // ),
            //       ),
            //     ],
            //   ),
            // ),
            // const Divider(
            //   thickness: 1,
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
                      Strings.EXIT,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      _presenter.onExitClick(widget.data);
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
  void setParkingLocationResponse(List<ParkingLocationData> data) {
    // TODO: implement setParkingLocationResponse
    showDialog(
            context: context, builder: (context) => ParkingLocationDialog(data))
        .then((value) => handleParkingLocationClick(value));
  }

  void handleParkingLocationClick(value) {
    if (value != null) {
      parkingLocationData = value;
      parkingLocationController.text =
          "${(parkingLocationData?.name ?? '')} (${(parkingLocationData?.capacity ?? '')})";
      _presenter.updateParkingLocation(
          parkingLocationData!, widget.data.transaction_id ?? '');
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
  void onDataUpdated() {
    // TODO: implement onDataUpdated
    widget.onDataUpdated();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    parkingLocationController.dispose();
    super.dispose();
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
  DriverListData? getDriverListData() {
    return driverListData;
  }

  @override
  void showPinDialog(ExitByHNData data, String masterKey, bool shouldShowPin) {
    // TODO: implement showPinDialog

    showDialog(
        context: context,
        builder: (context) => PopUpExitDialog(
            data.vehicle_number ?? "",
            data.hook_number ?? "",
            masterKey == "1",
            shouldShowPin)).then((value) => handlePinPassValue(data, value));
  }

  void handlePinPassValue(ExitByHNData data, value) {
    if (value != null && value is ExitPinPassArg) {
      String pin = value.pin ?? '';
      String password = value.password ?? '';
      _presenter.exitTranscation(data, pinNo: pin, password: password);
    }
  }
}
