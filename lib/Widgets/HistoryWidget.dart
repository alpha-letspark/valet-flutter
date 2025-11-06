import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/HistoryData.dart';

import '../Util/Strings.dart';

class HistoryWidget extends StatefulWidget {
  HistoryData history;
  HistoryWidget(this.history, {Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: ExpansionTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                trailing: _customTileExpanded
                    ? const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 30,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 30,
                      ),
                tilePadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          Strings.VEHICLE_NUMBER,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.history.vehicle_number ?? "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                widget.history.vehicle_name ?? "",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                children: [
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.VEHICLE_NAME,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.history.vehicle_name ?? "",
                            style: const TextStyle(
                                color: Colors.black54,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.VEHICLE_COLOR,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.history.vehicle_color ?? "",
                            style: const TextStyle(
                                color: Colors.black54,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.GUEST_NAME,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.history.guest_name ?? "",
                            style: const TextStyle(
                                color: Colors.black54,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.GUEST_NUMBER,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.history.guest_mobile ?? "",
                            style: const TextStyle(
                                color: Colors.black54,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.ANYTHING_VALUABLE,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            getValuebleText(),
                            style: const TextStyle(
                                color: Colors.black54,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.ADD_PHOTOS,
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.black26,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.black26,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.black26,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.black26,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(3)),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.black26,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            Strings.NOTES,
                            style: TextStyle(
                                color: Colors.black45,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.history.notes ?? "",
                            style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onExpansionChanged: (bool expanded) {
                  if (mounted) setState(() => _customTileExpanded = expanded);
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Row(
            //     children: [
            //       const Expanded(
            //         child: Text(
            //           Strings.GUEST_NAME,
            //           style: TextStyle(
            //               color: Colors.black45,
            //               fontSize: 15,
            //               fontWeight: FontWeight.w500),
            //         ),
            //       ),
            //       Expanded(
            //         child: Text(
            //           widget.history.guestName ?? "",
            //           style: const TextStyle(
            //               color: Colors.black54,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const Divider(
            //   thickness: 1,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.DATE_TIME_IN,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.history.entry_time ?? "",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        // const SizedBox(
                        //   width: 5,
                        // ),
                        // Text(
                        //   widget.history.timeIn ?? "",
                        //   style: TextStyle(
                        //       fontSize: 15,
                        //       color: Theme.of(context).primaryColor,
                        //       fontWeight: FontWeight.w500),
                        // )
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.VALET_DRIVER_IN,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.history.driver_in ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).primaryColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.DATE_TIME_OUT,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.history.exit_time ?? "",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.VALET_DRIVER_OUT,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.history.driver_out ?? "",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.LOCATION,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.history.parked_location ?? "",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.SLOTS,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.history.slots ?? "",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.HOOK_NUMBER,
                      style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.history.hook_number ?? "",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w600),
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

  String getValuebleText() {
    if ((widget.history.valuable ?? "") == "1") {
      return widget.history.valuable_things ?? "";
    }
    return "No";
  }
}
