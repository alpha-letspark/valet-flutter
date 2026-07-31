import 'dart:math';

import 'package:flutter/material.dart';
import 'package:valet_app/Data/ExitPinPassArg.dart';
import 'package:valet_app/Util/Strings.dart';

class PopUpExitDialog extends StatefulWidget {
  String vehicleNo;
  String hookNo;
  bool shouldShowPassword;
  bool shouldShowPin;

  PopUpExitDialog(
      this.vehicleNo, this.hookNo, this.shouldShowPassword, this.shouldShowPin,
      {Key? key})
      : super(key: key);

  @override
  State<PopUpExitDialog> createState() => _PopUpExitDialogState();
}

class _PopUpExitDialogState extends State<PopUpExitDialog> {
  TextEditingController passController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Strings.VEHICLE_NUMBER,
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.vehicleNo,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    widget.shouldShowPassword
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox(),
                    Visibility(
                      visible: widget.shouldShowPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  controller: passController,
                                  cursorColor: Theme.of(context).primaryColor,
                                  textAlign: TextAlign.center,
                                  enabled: pinController.text == '',
                                  onChanged: (text) {
                                    onPasswordChanged(text);
                                  },
                                  decoration: InputDecoration(
                                    hintText: Strings.ENTER_PASSWORD,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold),
                                    contentPadding: EdgeInsets.zero,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
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
                      visible:
                          widget.shouldShowPassword && widget.shouldShowPin,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.shouldShowPin,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: TextField(
                                  controller: pinController,
                                  enabled: passController.text == '',
                                  onChanged: (text) {
                                    onPinChanged(text);
                                  },
                                  cursorColor: Theme.of(context).primaryColor,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: "ENTER PIN ${widget.hookNo}-XXXX",
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold),
                                    contentPadding: EdgeInsets.zero,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                ExitPinPassArg arg = ExitPinPassArg();
                                arg.password = passController.text;
                                arg.pin = pinController.text;
                                Navigator.of(context).pop(arg);
                              },
                              fillColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pinController.dispose();
    passController.dispose();
    super.dispose();
  }

  void onPinChanged(String text) {
    if (mounted) setState(() {});
  }

  void onPasswordChanged(String text) {
    if (mounted) setState(() {});
  }
}
