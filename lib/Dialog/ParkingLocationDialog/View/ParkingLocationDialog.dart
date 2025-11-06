import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';

class ParkingLocationDialog extends StatelessWidget {
  List<ParkingLocationData> parkingList;
  ParkingLocationDialog(this.parkingList, {Key? key}) : super(key: key);

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
                      itemCount: parkingList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).pop(parkingList[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${(parkingList[index].name ?? '')} (${(parkingList[index].capacity ?? '')})",
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
