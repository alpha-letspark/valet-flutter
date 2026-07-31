import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

class PopUpPinDialog extends StatelessWidget {
  const PopUpPinDialog({Key? key}) : super(key: key);

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "KA01AB1234",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: TextField(
                                cursorColor: Theme.of(context).primaryColor,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: Strings.ENTER_PIN,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
