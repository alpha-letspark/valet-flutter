import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

class ExitConfirmDialog extends StatelessWidget {
  const ExitConfirmDialog({Key? key}) : super(key: key);

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Text(
                        Strings.WANT_TO_TAKE_VEHICLE_BACK,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                        softWrap: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                              )),
                              child: Text(
                                Strings.CONFIRM,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(true);
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
    );
  }
}
