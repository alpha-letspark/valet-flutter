import 'package:flutter/material.dart';
import 'package:valet_app/Data/Response/SummaryData.dart';
import 'package:valet_app/Dialog/NetworkImageDialog.dart';
import 'package:valet_app/SummaryScreen/presenter/SummaryPresenterImpl.dart';
import 'package:valet_app/SummaryScreenWidget/presenter/SummaryWidgetPresenterImpl.dart';
import 'package:valet_app/SummaryScreenWidget/view/SummaryScreenWidgetView.dart';

import '../../Util/Strings.dart';

class SummaryScreenWidget extends StatefulWidget {
  SummaryData data;
  SummaryScreenWidget(this.data, {Key? key}) : super(key: key);

  @override
  State<SummaryScreenWidget> createState() => _SummaryScreenStateWidget();
}

class _SummaryScreenStateWidget extends State<SummaryScreenWidget>
    implements SummaryScreenWidgetView {
  late SummaryWidgetPresenterImpl _presenter;

  bool _customTileExpanded = false;
  List<String> visibleFieldList = [];

  _SummaryScreenStateWidget() {
    _presenter = SummaryWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _presenter.getData(widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return getSummaryWidget(widget.data);
  }

  Widget getSummaryWidget(SummaryData data) {
    List<String> thumbnailImages = data.thumbnail_photo ?? [];
    List<String> vehicleImages = data.vehicle_photo ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
        color: Colors.grey[200],
        child: Column(children: [
          ExpansionTile(
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
            tilePadding: const EdgeInsets.symmetric(horizontal: 5),
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
                const SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          data.vehicle_number ?? "",
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          data.vehicle_type ?? "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
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
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VEHICLE_NAME),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.VEHICLE_NAME,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.vehicle_name ?? "",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VEHICLE_NAME),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.VEHICLE_COLOR,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.vehicle_color ?? "",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
                            data.entry_time ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600),
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
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_GUEST_NAME),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          data.guest_name ?? "",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_GUEST_NAME),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_GUEST_MOBILE),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.GUEST_NUMBER,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.guest_mobile ?? "",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_GUEST_MOBILE),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          Strings.Parked_By,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          data.parked_by ?? "",
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VALUABLE),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                        child: Visibility(
                          visible: data.valuable == "1",
                          child: Text(
                            data.valuable_things ?? '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_VALUABLE),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            thumbnailImages.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      String img = vehicleImages.isNotEmpty
                                          ? vehicleImages[0]
                                          : thumbnailImages[0];
                                      showPhoto(img);
                                    },
                                    child: Image.network((thumbnailImages[0]),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                      return const SizedBox();
                                    }, fit: BoxFit.fill, height: 25, width: 25),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: const Icon(
                                      Icons.directions_car,
                                      color: Colors.black54,
                                    ),
                                  ),
                            thumbnailImages.length >= 2
                                ? InkWell(
                                    onTap: () {
                                      String img = vehicleImages.length >= 2
                                          ? vehicleImages[1]
                                          : thumbnailImages[1];
                                      showPhoto(img);
                                    },
                                    child: Image.network((thumbnailImages[1]),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                      return const SizedBox();
                                    }, fit: BoxFit.fill, height: 25, width: 25),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: const Icon(
                                      Icons.directions_car,
                                      color: Colors.black54,
                                    ),
                                  ),
                            thumbnailImages.length >= 3
                                ? InkWell(
                                    onTap: () {
                                      String img = vehicleImages.length >= 3
                                          ? vehicleImages[2]
                                          : thumbnailImages[2];
                                      showPhoto(img);
                                    },
                                    child: Image.network((thumbnailImages[2]),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                      return const SizedBox();
                                    }, fit: BoxFit.fill, height: 25, width: 25),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: const Icon(
                                      Icons.directions_car,
                                      color: Colors.black54,
                                    ),
                                  ),
                            thumbnailImages.length >= 4
                                ? InkWell(
                                    onTap: () {
                                      String img = vehicleImages.length >= 4
                                          ? vehicleImages[3]
                                          : thumbnailImages[3];
                                      showPhoto(img);
                                    },
                                    child: Image.network((thumbnailImages[3]),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                      return const SizedBox();
                                    }, fit: BoxFit.fill, height: 25, width: 25),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: const Icon(
                                      Icons.directions_car,
                                      color: Colors.black54,
                                    ),
                                  ),
                            thumbnailImages.length >= 5
                                ? InkWell(
                                    onTap: () {
                                      String img = vehicleImages.length >= 5
                                          ? vehicleImages[4]
                                          : thumbnailImages[4];
                                      showPhoto(img);
                                    },
                                    child: Image.network((thumbnailImages[4]),
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                      return const SizedBox();
                                    }, fit: BoxFit.fill, height: 25, width: 25),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black54),
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
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_PHOTOS),
                child: const Divider(
                  thickness: 1,
                ),
              ),
              Visibility(
                visible: visibleFieldList.contains(Strings.MAND_NOTE),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        child: Text(
                          data.notes ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              if (mounted) setState(() => _customTileExpanded = expanded);
            },
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_VALET_DRIVER),
            child: const Divider(
              thickness: 1,
            ),
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_PARKING_LOT),
            child: Padding(
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
                    child: Text(
                      data.location ?? '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_PARKING_LOT),
            child: const Divider(
              thickness: 1,
            ),
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_SLOTS),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      Strings.SLOTS,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      data.slots ?? '',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_SLOTS),
            child: const Divider(
              thickness: 1,
            ),
          ),
          Visibility(
            visible: visibleFieldList.contains(Strings.MAND_HOOK_NUMBER),
            child: Padding(
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
                    child: Text(
                      data.hook_number ?? '',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void setVisibleFieldList(List<String> visibleFieldList) {
    // TODO: implement setVisibleFields
    this.visibleFieldList = visibleFieldList;
  }

  void showPhoto(String image) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
            scale: curve,
            child: image != "" ? NetworkImageDialog(image) : const SizedBox());
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
