import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valet_app/CardLostForm/view/CardLossFormDialogView.dart';
import 'package:valet_app/Util/Strings.dart';
import '../../ConnectivityStatusSingleton.dart';
import '../../Data/Response/ParkingDetailsData.dart';
import '../../Util/Utils.dart';
import '../presenter/CardLossFormPresenterImpl.dart';

class CardLossFormDialog extends StatefulWidget {
  ParkingDetailsData data;
  CardLossFormDialog(this.data, {Key? key}) : super(key: key);

  @override
  State<CardLossFormDialog> createState() => _CardLossFormDialogState();
}

class _CardLossFormDialogState extends State<CardLossFormDialog>
    implements CardLossFormDialogView {
  TextEditingController guestNameController = TextEditingController();
  TextEditingController guestMobileNoController = TextEditingController();
  TextEditingController fineAmountController = TextEditingController();
  bool guestNameError = false;
  bool mobileNoError = false;
  String guestNameErrorText = "Enter guest name.";
  String mandatoryFieldError = "This field is required.";
  bool isInit = false;

  Color? errorColor;
  Color? blackColor;
  File? rcPhoto;
  File? aadharPhoto;
  late CardLossFormPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  bool isLoading = false;
  bool isOffline = false;

  _CardLossFormDialogState() {
    _presenter = CardLossFormPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    guestMobileNoController.text = widget.data.guest_mobile ?? "";
    guestNameController.text = widget.data.guest_name ?? "";
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      errorColor ??= Theme.of(context).errorColor;
      blackColor ??= Colors.black;

      isInit = true;
    }
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
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
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const Text(
                  "Card loss detail form",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildStaticRow(
                  Strings.GUEST_NAME,
                  widget.data.guest_name ?? "",
                ),
                buildStaticRow(
                  Strings.HOOK_NUMBER,
                  widget.data.hook_number ?? "",
                ),
                buildStaticRow(
                  Strings.VEHICLE_NAME,
                  widget.data.vehicle_name ?? "",
                ),
                buildStaticRow(
                  Strings.DATE_TIME_IN,
                  widget.data.entry_time ?? "",
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: guestNameController,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {
                      if (guestNameError && text != '') {
                        guestNameError = false;

                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      labelStyle: guestNameError
                          ? TextStyle(color: errorColor)
                          : TextStyle(color: blackColor),
                      errorText: guestNameError ? guestNameErrorText : null,
                      counter: const Offstage(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: Strings.GUEST_NAME,
                      hintStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: guestMobileNoController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (text) {
                      if (mobileNoError && text != '') {
                        mobileNoError = false;

                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      labelStyle: mobileNoError
                          ? TextStyle(color: errorColor)
                          : TextStyle(color: blackColor),
                      errorText: mobileNoError ? mandatoryFieldError : null,
                      counter: const Offstage(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: Strings.GUEST_NUMBER,
                      hintStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: fineAmountController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (text) {},
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: blackColor),
                      counter: const Offstage(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: Strings.FINE_AMOUNT,
                      hintStyle: const TextStyle(fontSize: 12),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "RC Card",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Aadhar Card",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
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
                              fontWeight: FontWeight.w700,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          onSubmitClick();
                        },
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          )
        ]),
      ),
    ));
  }

  Widget buildStaticRow(String header, String value) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                header,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                value,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  String getGuestName() {
    return guestNameController.text;
  }

  @override
  String getGuestNumber() {
    return guestMobileNoController.text;
  }

  @override
  String getFineAmount() {
    return fineAmountController.text;
  }

  @override
  File? getRCPhoto() {
    return rcPhoto;
  }

  @override
  File? getAadharCardPhoto() {
    return aadharPhoto;
  }

  void onSubmitClick() {
    if (getGuestName() == "") {
      guestNameError = true;
    }
    if (getGuestNumber() == "") {
      mobileNoError = true;
    }

    if (guestNameError || mobileNoError) {
      setState(() {});
      return;
    }
    String transcationId = widget.data.transaction_id ?? "";
    String hookNumber = widget.data.hook_number ?? "";
    _presenter.onSubmitClick(transcationId, hookNumber);
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
  void onTranscationSuccess() {
    Navigator.of(context).pop();
  }
}
