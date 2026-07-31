import 'package:flutter/material.dart';
import 'package:valet_app/Util/Strings.dart';

import '../../../Data/Response/VehicleTypeData.dart';

class VehicleTypeDialog extends StatefulWidget {
  List<VehicleTypeData> vehicleTypeList;
  VehicleTypeDialog(this.vehicleTypeList, {Key? key}) : super(key: key);

  @override
  State<VehicleTypeDialog> createState() => _VehicleTypeDialogState();
}

class _VehicleTypeDialogState extends State<VehicleTypeDialog> {
  int selectedCarIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Container(
            color: Colors.grey[100],
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        Strings.VEHICLE_TYPE,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.vehicleTypeList.length,
                      itemBuilder: ((context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pop(widget.vehicleTypeList[index]);
                                // if (mounted) setState(() {
                                //   selectedCarIndex =
                                //       widget.vehicleTypeList[index].id ?? 0;
                                // });
                              },
                              child: Column(
                                children: [
                                  Image.network(
                                    (widget.vehicleTypeList[index].photos ??
                                        ''),
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const SizedBox();
                                    },
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(widget.vehicleTypeList[index].name ?? '',
                                      style: (selectedCarIndex ==
                                              widget.vehicleTypeList[index].id)
                                          ? TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : const TextStyle(
                                              color: Colors.black)),
                                ],
                              )),
                        );
                      })),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
