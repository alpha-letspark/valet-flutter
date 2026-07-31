import 'package:flutter/material.dart';
import 'package:valet_app/Data/historyData.dart';
import 'package:valet_app/Dialog/NotesDialog/View/NotesDialog.dart';
import 'package:valet_app/Dialog/ParkingLocationDialog/View/ParkingLocationDialog.dart';
import 'package:valet_app/Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import 'package:valet_app/Dialog/VehicleTypeDialog/View/VehicleTypeDialog.dart';
import 'package:valet_app/Util/Strings.dart';

class ParkedTab extends StatefulWidget {
  ParkedTab({Key? key}) : super(key: key);

  @override
  State<ParkedTab> createState() => _ParkedTabState();
}

class _ParkedTabState extends State<ParkedTab> {
  final List<History> _history = [
    History(
        "KA02CD4567",
        "SUV",
        "Nirav Kumar",
        "+91 9876543210",
        "10:10 am",
        "01/02/2021",
        "Arvind Kumar",
        "2:00 pm",
        "01/02/2021",
        "Pawan Kumar",
        "NO",
        "21",
        "ATM",
        "notes",
        "READY"),
    History(
        "KA02CD4567",
        "SUV",
        "Nirav Kumar",
        "+91 9876543210",
        "10:10 am",
        "01/02/2021",
        "Arvind Kumar",
        "2:00 pm",
        "01/02/2021",
        "Pawan Kumar",
        "NO",
        "21",
        "ATM",
        "notes",
        "READY"),
    History(
        "KA02CD4567",
        "SUV",
        "Nirav Kumar",
        "+91 9876543210",
        "10:10 am",
        "01/02/2021",
        "Arvind Kumar",
        "2:00 pm",
        "01/02/2021",
        "Pawan Kumar",
        "NO",
        "21",
        "ATM",
        "notes",
        "READY"),
    History(
        "KA1236547",
        "SUV",
        "Nirav Kumar",
        "+91 9876543210",
        "10:10 am",
        "01/02/2021",
        "Arvind Kumar",
        "2:00 pm",
        "01/02/2021",
        "Pawan Kumar",
        "NO",
        "21",
        "ATM",
        "notes",
        "READY")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: TextField(
                  style: TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      contentPadding: EdgeInsets.zero,
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: Strings.SEARCH_VEHICLE_MOBILE,
                      hintStyle: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: _history.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        ExpansionTile(
                          tilePadding:
                              const EdgeInsets.symmetric(horizontal: 5),
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
                              Expanded(
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        readOnly: true,
                                        showCursor: false,
                                        decoration: InputDecoration(
                                            hintText:
                                                _history[index].vehicleNumber!,
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  VehicleTypeDialog([]));
                                        },
                                        showCursor: false,
                                        decoration: InputDecoration(
                                            hintText:
                                                _history[index].vehicleName!,
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                            border: InputBorder.none),
                                      ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          _history[index].dateIn!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _history[index].timeIn!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                                      _history[index].guestName!,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      Strings.GUEST_NUMBER + "*",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _history[index].guestNumber!,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      Strings.ANYTHING_VALUABLE,
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      _history[index].valuableThing!,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      Strings.ADD_PHOTOS,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
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
                                        Container(
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
                                        Container(
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
                                        Container(
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
                                        Container(
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
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      Strings.NOTES,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                NotesDialog(''));
                                      },
                                      readOnly: true,
                                      showCursor: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        hintText: Strings.UNASSIGNED,
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  Strings.VALET_DRIVER,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            SelectDriverDialog([]));
                                  },
                                  showCursor: false,
                                  readOnly: true,
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
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
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
                                child: TextField(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            ParkingLocationDialog([]));
                                  },
                                  showCursor: false,
                                  readOnly: true,
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
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  Strings.HOOK_NUMBER,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  showCursor: false,
                                  readOnly: true,
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
                            ],
                          ),
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
                                onPressed: () {},
                                fillColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
