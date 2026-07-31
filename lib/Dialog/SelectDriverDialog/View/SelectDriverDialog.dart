import 'package:flutter/material.dart';

import '../../../Data/Response/DriverListData.dart';

class SelectDriverDialog extends StatefulWidget {
  List<DriverListData> data;
  SelectDriverDialog(this.data, {Key? key}) : super(key: key);

  @override
  State<SelectDriverDialog> createState() => _SelectDriverDialogState();
}

class _SelectDriverDialogState extends State<SelectDriverDialog> {
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
                    color: Colors.grey[200],
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black26,
                      ),
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: (() {
                          Navigator.of(context).pop(widget.data[index]);
                        }),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.data[index].name ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
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
    );
  }
}
