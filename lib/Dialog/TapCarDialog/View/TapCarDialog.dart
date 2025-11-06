import 'package:flutter/material.dart';
import 'package:valet_app/CardLostForm/view/CardLossFormDialog.dart';
import 'package:valet_app/Dialog/NetworkImageDialog.dart';
import 'package:valet_app/Dialog/TapCarDialog/Presenter/TapCarDialogPresenterImpl.dart';
import 'package:valet_app/Dialog/TapCarDialog/View/TapCarDialogView.dart';
import 'package:valet_app/Util/Strings.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/ExitPinPassArg.dart';
import '../../../Data/Response/ParkingDetailsData.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Util/Utils.dart';
import '../../ParkingLocationDialog/View/ParkingLocationDialog.dart';
import '../../PopUpExitDialog/View/PopUpExitDialog.dart';

class TapCarDialog extends StatefulWidget {
  ParkingDetailsData data;
  TapCarDialog(this.data, {Key? key}) : super(key: key);

  @override
  State<TapCarDialog> createState() => _TapCarDialogState();
}

class _TapCarDialogState extends State<TapCarDialog>
    implements TapCarDialogView {
  TextEditingController parkingLocationController = TextEditingController();

  late TapCarDialogPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  bool isOffline = false;
  bool isLoading = false;

  ParkingLocationData? parkingLocationData;

  List<String> thumbnailImages = [];
  List<String> vehicleImages = [];

  _TapCarDialogState() {
    _presenter = TapCarDialogPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    //  WidgetsBinding.instance!.addPostFrameCallback((_) => initData());
    parkingLocationController.text = widget.data.location ?? "";
    thumbnailImages = widget.data.thumbnail_photo ?? [];
    vehicleImages = widget.data.vehicle_photo ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Container(
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.HOOK_NUMBER,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.hook_number ?? "",
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.VEHICLE_NUMBER,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    widget.data.vehicle_number ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: Text(
                                        widget.data.vehicle_type ?? "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.VEHICLE_NAME,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    widget.data.vehicle_name ?? "",
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.VEHICLE_COLOR,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widget.data.vehicle_color ?? "",
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.DATE_TIME,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    widget.data.entry_time ?? "",
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.GUEST_NAME,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.guest_name ?? "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.GUEST_NUMBER,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.guest_mobile ?? "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.ANYTHING_VALUABLE,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.valuable == "1" ? "Yes" : "No",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.ADD_PHOTOS,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  thumbnailImages.isNotEmpty
                                      ? InkWell(
                                          onTap: () {
                                            String img =
                                                vehicleImages.isNotEmpty
                                                    ? vehicleImages[0]
                                                    : thumbnailImages[0];
                                            showPhoto(img);
                                          },
                                          child: Image.network(
                                              (thumbnailImages[0]),
                                              errorBuilder:
                                                  (BuildContext context,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          child: const Icon(
                                            Icons.directions_car,
                                            color: Colors.black54,
                                          ),
                                        ),
                                  thumbnailImages.length >= 2
                                      ? InkWell(
                                          onTap: () {
                                            String img =
                                                vehicleImages.length >= 2
                                                    ? vehicleImages[1]
                                                    : thumbnailImages[1];
                                            showPhoto(img);
                                          },
                                          child: Image.network(
                                              (thumbnailImages[1]),
                                              errorBuilder:
                                                  (BuildContext context,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          child: const Icon(
                                            Icons.directions_car,
                                            color: Colors.black54,
                                          ),
                                        ),
                                  thumbnailImages.length >= 3
                                      ? InkWell(
                                          onTap: () {
                                            String img =
                                                vehicleImages.length >= 3
                                                    ? vehicleImages[2]
                                                    : thumbnailImages[2];
                                            showPhoto(img);
                                          },
                                          child: Image.network(
                                              (thumbnailImages[2]),
                                              errorBuilder:
                                                  (BuildContext context,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          child: const Icon(
                                            Icons.directions_car,
                                            color: Colors.black54,
                                          ),
                                        ),
                                  thumbnailImages.length >= 4
                                      ? InkWell(
                                          onTap: () {
                                            String img =
                                                vehicleImages.length >= 4
                                                    ? vehicleImages[3]
                                                    : thumbnailImages[3];
                                            showPhoto(img);
                                          },
                                          child: Image.network(
                                              (thumbnailImages[3]),
                                              errorBuilder:
                                                  (BuildContext context,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            border: Border.all(
                                                color: Colors.black54),
                                          ),
                                          child: const Icon(
                                            Icons.directions_car,
                                            color: Colors.black54,
                                          ),
                                        ),
                                  thumbnailImages.length >= 5
                                      ? InkWell(
                                          onTap: () {
                                            String img =
                                                vehicleImages.length >= 5
                                                    ? vehicleImages[4]
                                                    : thumbnailImages[4];
                                            showPhoto(img);
                                          },
                                          child: Image.network(
                                              (thumbnailImages[4]),
                                              errorBuilder:
                                                  (BuildContext context,
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            border: Border.all(
                                                color: Colors.black54),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.NOTES,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.notes ?? "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.VALET_DRIVER,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.driver ?? "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.LOCATION,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //       decoration: BoxDecoration(
                            //         borderRadius: const BorderRadius.all(
                            //             Radius.circular(3)),
                            //         border: Border.all(color: Colors.black12),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(5.0),
                            //         child: Text(
                            //           widget.data.location ?? "",
                            //           style: const TextStyle(
                            //               fontWeight: FontWeight.w600,
                            //               color: Colors.black26),
                            //         ),
                            //       )),
                            // ),
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    hintText: Strings.UNASSIGNED,
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                Strings.SLOTS,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.data.slots ?? "",
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              Strings.CARD_LOST_TEXT,
                              style: TextStyle(
                                  color: Colors.red[900], fontSize: 14),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                openCardLossDialog(widget.data);
                              },
                              child: const Text(
                                Strings.CARD_LOST,
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                )),
                                child: Text(
                                  Strings.SUBMIT,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () {
                                  _presenter.onSubmitClick();
                                },
                                fillColor: Colors.white,
                              ),
                            ),
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    }
  }

  @override
  ParkingLocationData? getParkingLocation() {
    return parkingLocationData;
  }

  @override
  ParkingDetailsData getParkingDetailsData() {
    return widget.data;
  }

  @override
  void onTransactionUpdated() {
    Navigator.of(context).pop(true);
  }

  @override
  void showPinDialog(
      ParkingDetailsData data, String masterKey, bool shouldShowPin) {
    // TODO: implement showPinDialog

    showDialog(
        context: context,
        builder: (context) => PopUpExitDialog(
            data.vehicle_number ?? "",
            data.hook_number ?? "",
            masterKey == "1",
            shouldShowPin)).then((value) => handlePinPassValue(data, value));
  }

  void handlePinPassValue(ParkingDetailsData data, value) {
    if (value != null && value is ExitPinPassArg) {
      String pin = value.pin ?? '';
      String password = value.password ?? '';
      _presenter.exitTranscation(data, pinNo: pin, password: password);
    }
  }

  @override
  void onTranscationSuccess() {
    Navigator.of(context).pop(true);
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

  void openCardLossDialog(ParkingDetailsData data) {
    if (data != null) {
      showDialog(
          context: context, builder: (context) => CardLossFormDialog(data));
    }
  }
}
