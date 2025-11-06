import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:valet_app/Data/Response/UnparkedListData.dart';
import 'package:valet_app/Dialog/NetworkImageDialog.dart';
import 'package:valet_app/Widgets/UnParkedListWidget/Presenter/UnParkedListWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/UnParkedListWidget/View/UnParkedListWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/SlotsData.dart';
import '../../../Data/Response/VehicleTypeData.dart';
import '../../../Dialog/NotesDialog/View/NotesDialog.dart';
import '../../../Dialog/ParkingLocationDialog/View/ParkingLocationDialog.dart';
import '../../../Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import '../../../Dialog/VehicleTypeDialog/View/VehicleTypeDialog.dart';
import '../../../Util/Strings.dart';
import '../../../Util/Utils.dart';

class UnParkedListWidget extends StatefulWidget {
  UnparkedListData data;
  Function onTranscationSuccessful;
  UnParkedListWidget(this.data, this.onTranscationSuccessful, {Key? key})
      : super(key: key);

  @override
  State<UnParkedListWidget> createState() => _UnParkedListWidgetState();
}

class _UnParkedListWidgetState extends State<UnParkedListWidget>
    implements UnParkedListWidgetView {
  bool _customTileExpanded = false;
  bool isOffline = false;
  bool isLoading = false;

  List<String> visibleFieldList = [];
  List<String> mandetoryFieldList = [];
  List<SlotsData> slotsList = [];

  late UnParkedListWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;

  TextEditingController vehicalNumberController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController valuableNoteController = TextEditingController();
  TextEditingController valetDriverController = TextEditingController();
  TextEditingController parkingLocationController = TextEditingController();
  TextEditingController hookNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController slotsController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();

  bool vehicleNumberError = false;
  bool mobileeNumberError = false;
  bool emailError = false;
  bool nameError = false;
  bool valuableError = false;
  bool valetDriverrError = false;
  bool parkingLocationError = false;
  bool hookNumberError = false;
  bool notesError = false;
  bool vehicleTypeError = false;
  bool slotsError = false;
  bool vehicleNameError = false;
  bool vehicleColorError = false;

  String mandetoryFieldError = "This field is mandatory";

  ParkingLocationData? parkingLocationData;
  DriverListData? driverListData;
  int selectedCarIndex = 0;
  List<String> uploadedPhoto = [];
  String isValuable = '';
  bool isYesClicked = false;
  bool isNoClicked = false;
  Color? errorColor;
  Color? blackColor;
  List<String> thumbnailImages = [];
  List<String> vehicleImages = [];

  _UnParkedListWidgetState() {
    _presenter = UnParkedListWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initData());
  }

  void initData() {
    _presenter.initData(widget.data);
    vehicalNumberController.text = widget.data.vehicle_number ?? "";
    vehicleTypeController.text = widget.data.vehicle_type ?? "";
    nameController.text = widget.data.guest_name ?? "";
    mobileNumberController.text = widget.data.guest_mobile ?? "";
    emailController.text = widget.data.guest_email ?? "";
    valuableNoteController.text = widget.data.valuable_things ?? "";
    notesController.text = widget.data.notes ?? "";
    valetDriverController.text = widget.data.driver ?? "";
    parkingLocationController.text = widget.data.location ?? "";
    hookNumberController.text = widget.data.hook_number ?? "";
    isValuable = widget.data.valuable ?? '';
    isYesClicked = widget.data.valuable == '1' ? true : false;
    isNoClicked = widget.data.valuable == '0' ? true : false;
    slotsController.text = widget.data.slots ?? '';
    vehicleColorController.text = widget.data.vehicle_color ?? '';
    vehicleNameController.text = widget.data.vehicle_name ?? '';
    thumbnailImages = widget.data.thumbnail_photo ?? [];
    vehicleImages = widget.data.vehicle_photo ?? [];

    if (widget.data.location_id != null && widget.data.location != '') {
      ParkingLocationData pl = ParkingLocationData();
      pl.id = int.tryParse(widget.data.location_id ?? '');
      pl.name = widget.data.location;
      if (pl.id != null && pl.id != 0) parkingLocationData = pl;
    }

    if (widget.data.location_id != null && widget.data.location != '') {
      DriverListData? dl = DriverListData();
      dl.id = int.tryParse(widget.data.driver_id ?? '');
      dl.name = widget.data.driver;
      if (dl.id != null && dl.id != 0) driverListData = dl;
    }

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    errorColor ??= Theme.of(context).errorColor;
    blackColor ??= Colors.black;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
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
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: vehicalNumberController,
                              showCursor: false,
                              onChanged: (value) {
                                if (vehicleNumberError && value != '') {
                                  vehicleNumberError = false;
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle: vehicleNumberError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: vehicleNumberError
                                    ? mandetoryFieldError
                                    : null,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            onTap: () {
                              _presenter.getVehicleType();
                            },
                            showCursor: false,
                            controller: vehicleTypeController,
                            decoration: InputDecoration(
                                labelStyle: vehicleTypeError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: vehicleTypeError
                                    ? mandetoryFieldError
                                    : null,
                                hintText: widget.data.vehicle_type ?? "",
                                hintStyle:
                                    const TextStyle(color: Colors.black87),
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
                              widget.data.entry_time ?? "",
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 40,
                              child: TypeAheadFormField(
                                noItemsFoundBuilder: (context) {
                                  return const SizedBox();
                                },
                                getImmediateSuggestions: true,
                                autoFlipDirection: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  onChanged: ((value) {
                                    if (vehicleNameError && value != '') {
                                      vehicleNameError = false;
                                      setState(() {});
                                    }
                                  }),
                                  controller: vehicleNameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelStyle: vehicleNameError
                                        ? TextStyle(color: errorColor)
                                        : TextStyle(color: blackColor),
                                    errorText: vehicleNameError
                                        ? mandetoryFieldError
                                        : null,
                                    counter: const SizedBox(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    filled: true,
                                    hintText: Strings.UNASSIGNED,
                                    fillColor: Colors.white,
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black38),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(
                                        hasScrollbar: true,
                                        color: Colors.white),
                                suggestionsCallback: (pattern) {
                                  if (pattern.isNotEmpty) {
                                    return _presenter
                                        .suggestVehicleName(pattern);
                                  }
                                  return [];
                                },
                                itemBuilder: (context, dynamic suggestion) {
                                  return suggestion != null
                                      ? ListTile(
                                          title: Text(suggestion.name ?? ""))
                                      : const SizedBox();
                                },
                                onSuggestionSelected: (dynamic suggestion) {
                                  vehicleNameController.text = suggestion.name;
                                  if (mounted) setState(() {});
                                },
                              ),
                            ),
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
                  visible:
                      visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
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
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: SizedBox(
                              height: 40,
                              child: TypeAheadFormField(
                                noItemsFoundBuilder: (context) {
                                  return const SizedBox();
                                },
                                getImmediateSuggestions: true,
                                autoFlipDirection: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  onChanged: ((value) {
                                    if (vehicleColorError && value != '') {
                                      vehicleColorError = false;
                                      setState(() {});
                                    }
                                  }),
                                  controller: vehicleColorController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    labelStyle: vehicleColorError
                                        ? TextStyle(color: errorColor)
                                        : TextStyle(color: blackColor),
                                    errorText: vehicleColorError
                                        ? mandetoryFieldError
                                        : null,
                                    counter: const SizedBox(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    filled: true,
                                    hintText: Strings.UNASSIGNED,
                                    fillColor: Colors.white,
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black38),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                ),
                                suggestionsBoxDecoration:
                                    const SuggestionsBoxDecoration(
                                        hasScrollbar: true,
                                        color: Colors.white),
                                suggestionsCallback: (pattern) {
                                  if (pattern.isNotEmpty) {
                                    return _presenter
                                        .suggestVehicleColor(pattern);
                                  }
                                  return [];
                                },
                                itemBuilder: (context, dynamic suggestion) {
                                  return suggestion != null
                                      ? ListTile(
                                          title:
                                              Text(suggestion.color_name ?? ""))
                                      : const SizedBox();
                                },
                                onSuggestionSelected: (dynamic suggestion) {
                                  vehicleColorController.text =
                                      suggestion.color_name ?? '';
                                  if (mounted) setState(() {});
                                },
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
                      visibleFieldList.contains(Strings.MAND_VEHICLE_COLOR),
                  child: const Divider(
                    thickness: 1,
                  ),
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
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (nameError && value != '') {
                                  nameError = false;
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle: nameError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText:
                                    nameError ? mandetoryFieldError : null,
                                counter: const Offstage(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: Strings.UNASSIGNED,
                                hintStyle: const TextStyle(fontSize: 12),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black38)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
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
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              controller: mobileNumberController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              onChanged: (value) {
                                if (mobileeNumberError && value != '') {
                                  mobileeNumberError = false;
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle: mobileeNumberError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: mobileeNumberError
                                    ? mandetoryFieldError
                                    : null,
                                counter: const Offstage(),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: Strings.UNASSIGNED,
                                hintStyle: const TextStyle(fontSize: 12),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black38),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
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
                  visible: visibleFieldList.contains(Strings.MAND_GUEST_MOBILE),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  OutlinedButton(
                                      style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              BorderSide(
                                                  color: isYesClicked
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black45)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white)),
                                      onPressed: () {
                                        if (mounted) {
                                          setState(() {
                                            isYesClicked = true;
                                            isNoClicked = false;
                                            isValuable = "1";
                                          });
                                        }
                                      },
                                      child: const Text(
                                        Strings.YES,
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  OutlinedButton(
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                color: isNoClicked
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors.black45)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        if (mounted) {
                                          setState(() {
                                            isNoClicked = true;
                                            isYesClicked = false;
                                            isValuable = "0";
                                          });
                                        }
                                      },
                                      child: const Text(
                                        Strings.NO,
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                ],
                              ),
                              Visibility(
                                visible: isYesClicked,
                                child: const SizedBox(
                                  height: 10,
                                ),
                              ),
                              Visibility(
                                  visible: isValuable == '',
                                  child: Text(
                                    mandetoryFieldError,
                                    style: TextStyle(color: errorColor),
                                  )),
                              Visibility(
                                visible: isYesClicked,
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: valuableNoteController,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: Strings.ENTER_VALUABLE_THINGS,
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black38)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
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
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
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
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
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
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
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
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
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
                                      },
                                          fit: BoxFit.fill,
                                          height: 25,
                                          width: 25),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3)),
                                        border:
                                            Border.all(color: Colors.black54),
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
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onTap: () {
                                showDialog(
                                        context: context,
                                        builder: (context) =>
                                            NotesDialog(notesController.text))
                                    .then((value) => handleNotesValue(value));
                              },
                              readOnly: true,
                              showCursor: false,
                              controller: notesController,
                              decoration: InputDecoration(
                                labelStyle: notesError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText:
                                    notesError ? mandetoryFieldError : null,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onTap: () {
                            _presenter.getDriverList();
                          },
                          showCursor: false,
                          readOnly: true,
                          controller: valetDriverController,
                          decoration: InputDecoration(
                            labelStyle: valetDriverrError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                valetDriverrError ? mandetoryFieldError : null,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            hintText: Strings.UNASSIGNED,
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
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
              visible: visibleFieldList.contains(Strings.MAND_HOOK_NUMBER),
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
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          showCursor: false,
                          enabled: false,
                          controller: hookNumberController,
                          decoration: InputDecoration(
                            labelStyle: hookNumberError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                hookNumberError ? mandetoryFieldError : null,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            hintText: Strings.UNASSIGNED,
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
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
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          onTap: () {
                            _presenter.getParkingLocationList();
                          },
                          showCursor: false,
                          readOnly: true,
                          controller: parkingLocationController,
                          decoration: InputDecoration(
                            labelStyle: parkingLocationError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText: parkingLocationError
                                ? mandetoryFieldError
                                : null,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            hintText: Strings.UNASSIGNED,
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
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
                      child: SizedBox(
                        height: 45,
                        child: TypeAheadFormField(
                          noItemsFoundBuilder: (context) {
                            return const SizedBox();
                          },
                          getImmediateSuggestions: true,
                          autoFlipDirection: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: slotsController,
                            onChanged: (text) {
                              if (slotsError && text != '') {
                                slotsError = false;
                                setState(() {});
                              }
                            },
                            decoration: InputDecoration(
                              labelStyle: slotsError
                                  ? TextStyle(color: errorColor)
                                  : TextStyle(color: blackColor),
                              errorText:
                                  slotsError ? mandetoryFieldError : null,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Type',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              counter: const Offstage(),
                            ),
                          ),
                          suggestionsBoxDecoration:
                              const SuggestionsBoxDecoration(
                                  hasScrollbar: true, color: Colors.white),
                          suggestionsCallback: (pattern) {
                            return slotsList;
                          },
                          itemBuilder: (context, dynamic suggestion) {
                            return suggestion != null
                                ? ListTile(
                                    title: Text(suggestion.name ?? ""),
                                  )
                                : const SizedBox();
                          },
                          onSuggestionSelected: (dynamic suggestion) {
                            slotsController.text = suggestion.name ?? "";
                          },
                        ),
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
                      _presenter.onSubmitClick(widget.data);
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

  @override
  String getVehicleNumber() {
    return vehicalNumberController.text;
  }

  @override
  int getVehicleType() {
    return selectedCarIndex;
  }

  @override
  String getGuestMobileNumber() {
    return mobileNumberController.text;
  }

  @override
  String getGuestName() {
    return nameController.text;
  }

  @override
  String getGuestEmail() {
    return emailController.text;
  }

  @override
  String isValuableSelected() {
    return isValuable;
  }

  @override
  String isValueableText() {
    return valuableNoteController.text;
  }

  @override
  DriverListData? getDriverData() {
    return driverListData;
  }

  @override
  ParkingLocationData? getParkingLocationData() {
    return parkingLocationData;
  }

  @override
  String getHookNumber() {
    return hookNumberController.text;
  }

  @override
  String getNotes() {
    return notesController.text;
  }

  @override
  List<String> getUploadedPhoto() {
    return uploadedPhoto;
  }

  @override
  Future<bool> isOnline() async {
    return isOffline = await connectionStatus.checkConnection();
  }

  @override
  void showOfflineMessage() {
    showErrorMsg(Strings.OFFLINE_MESSAGE);
    if (isLoading) {
      hideProgress();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void showProgress() {
    // TODO: implement showProgress

    if (!isLoading) {
      isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
              height: 30,
              width: 30,
              child: Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor)));
        },
      ).then((value) => isLoading = false);
    }
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
    if (isLoading) {
      isLoading = false;
      Navigator.pop(context);
    }
  }

  @override
  void showErrorMsg(String? msg) {
    Utils.showToastMsg(msg!,
        textColor: Colors.black, backgroundColor: Colors.white);
  }

  @override
  void setVehicleType(List<VehicleTypeData> vehicleTypeList) {
    // TODO: implement setVehicleType
    showDialog(
            context: context,
            builder: (context) => VehicleTypeDialog(vehicleTypeList))
        .then((value) => handleVehicleTypeClick(value));
  }

  void handleVehicleTypeClick(value) {
    if (value != null && value is VehicleTypeData) {
      vehicleTypeController.text = value.name ?? "";
      vehicleColorError = false;
      if (mounted) setState(() {});
    }
  }

  @override
  void setParkingLocationResponse(List<ParkingLocationData> data) {
    // TODO: implement setParkingLocationResponse
    showDialog(
            context: context, builder: (context) => ParkingLocationDialog(data))
        .then((value) => handleParkingLocationClick(value));
  }

  void handleParkingLocationClick(value) {
    if (value != null) {
      parkingLocationData = value;
      parkingLocationError = false;
      parkingLocationController.text =
          "${(parkingLocationData?.name ?? '')} (${(parkingLocationData?.capacity ?? '')})";
      slotsController.text = '';
      _presenter.onParkingLocationSelected(parkingLocationData);
    }
  }

  @override
  void setDriverListResponse(List<DriverListData> data) {
    // TODO: implement setParkingLocationResponse
    showDialog(context: context, builder: (context) => SelectDriverDialog(data))
        .then((value) => handleDriverListClick(value));
  }

  void handleDriverListClick(value) {
    if (value != null) {
      driverListData = value;
      valetDriverrError = false;
      valetDriverController.text = (driverListData?.name ?? '');
      setState(() {});
    }
  }

  void handleNotesValue(value) {
    if (value != null) {
      notesController.text = value;
      notesError = false;
      if (mounted) setState(() {});
    }
  }

  @override
  void setVisibleFieldList(List<String> visible) {
    // TODO: implement setVisibleFieldList
    visibleFieldList = visible;
  }

  @override
  void setMandatoryFieldList(List<String> mandatory) {
    // TODO: implement setMandatoryFieldList
    mandetoryFieldList = mandatory;

    if (mounted) setState(() {});
  }

  @override
  void onTranscationSuccess() {
    widget.onTranscationSuccessful();
  }

  @override
  String getSlots() {
    // TODO: implement getSlots
    return slotsController.text;
  }

  @override
  void setSlotsList(List<SlotsData> slotsList) {
    // TODO: implement setSlotsList
    this.slotsList = slotsList;
    setState(() {});
  }

  @override
  String getVehicleColor() {
    // TODO: implement getVehicleColor
    return vehicleColorController.text;
  }

  @override
  String getVehicleName() {
    // TODO: implement getVehicleName
    return vehicleNameController.text;
  }

  @override
  void setErrorFields(
      bool vehicleNumberError,
      bool mobileeNumberError,
      bool emailError,
      bool nameError,
      bool valuableError,
      bool valetDriverrError,
      bool parkingLocationError,
      bool hookNumberError,
      bool notesError,
      bool vehicleTypeError,
      bool slotsError,
      bool vehicleNameError,
      bool vehicleColorError) {
    // TODO: implement setErrorFields
    this.vehicleNumberError = vehicleNumberError;
    this.mobileeNumberError = mobileeNumberError;
    this.emailError = emailError;
    this.nameError = nameError;
    this.valuableError = valuableError;
    this.valetDriverrError = valetDriverrError;
    this.parkingLocationError = parkingLocationError;
    this.hookNumberError = hookNumberError;
    this.notesError = notesError;
    this.vehicleTypeError = vehicleTypeError;
    this.slotsError = slotsError;
    this.vehicleNameError = vehicleNameError;
    this.vehicleColorError = vehicleColorError;
    setState(() {});
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
