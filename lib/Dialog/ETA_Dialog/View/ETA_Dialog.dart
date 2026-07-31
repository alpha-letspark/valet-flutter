import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

class ETA_Dialog extends StatefulWidget {
  List<String?> etaTime;
  ETA_Dialog(this.etaTime, {Key? key}) : super(key: key);

  @override
  State<ETA_Dialog> createState() => _ETA_DialogState();
}

class _ETA_DialogState extends State<ETA_Dialog> {
  int _selectedItem = 0;
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
              child: Column(
                children: [
                  Container(
                    color: Colors.grey[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            Strings.ENTER_ETA,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  children:
                      List<Widget>.generate(widget.etaTime.length, (int index) {
                    return Center(
                      child: Text(
                        widget.etaTime[index] ?? "",
                      ),
                    );
                  }),
                  onSelectedItemChanged: (value) {
                    _selectedItem = value;
                  },
                  itemExtent: 25,
                  diameterRatio: 1,
                ),
              ),
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
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(widget.etaTime[_selectedItem]);
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
}
