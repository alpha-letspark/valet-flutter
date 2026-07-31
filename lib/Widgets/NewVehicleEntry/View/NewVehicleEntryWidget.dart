import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valet_app/Data/Response/CheckHookNumberResponse.dart';
import 'package:valet_app/Data/Response/DriverListData.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Data/Response/ScanNumberPlateResponse.dart';
import 'package:valet_app/Data/Response/SearchGuestData.dart';
import 'package:valet_app/Data/Response/SlotsData.dart';
import 'package:valet_app/Data/Response/VehicleTypeData.dart';
import 'package:valet_app/Dialog/ParkingLocationDialog/View/ParkingLocationDialog.dart';
import 'package:valet_app/Dialog/SelectDriverDialog/View/SelectDriverDialog.dart';
import 'package:valet_app/SignatureScreen/View/SignatureScreen.dart';

import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/NewVehicleEntry/Presenter/NewVehicleEntryWidgetPresenterImpl.dart';
import 'package:valet_app/Widgets/NewVehicleEntry/View/NewVehicleEntryWidgetView.dart';

import '../../../ConnectivityStatusSingleton.dart';
import '../../../Data/Response/InputFieldResponse.dart';
import '../../../Dialog/ImageDialog.dart';
import '../../../Util/Utils.dart';

class NewVehicleEntry extends StatefulWidget {
  Function onVehicleAdded;
  NewVehicleEntry(this.onVehicleAdded, {Key? key}) : super(key: key);

  var state = _NewVehicleEntryState();
  @override
  //State<NewVehicleEntry> createState() => _state;
  @override
  _NewVehicleEntryState createState() {
    return state = new _NewVehicleEntryState();
  }

  void refresh() => state.refresh();
}

class _NewVehicleEntryState extends State<NewVehicleEntry>
    implements NewVehicleEntryWidgetView {
  bool isLoading = false;
  bool isOffline = false;

  bool isSms = true;
  bool isHookError = false;
  bool isParked = true;
  bool isScanClicked = false;
  bool isYesClicked = false;
  bool isNoClicked = false;
  int selectedCarIndex = -1;
  bool isParkedPermission = false;

  String isValuable = "";

  String? hookMessage;
  File? signatureFile;
  DriverListData? driverListData;
  ParkingLocationData? parkingLocationData;
  List<String> uploadedPhoto = [];

  List<VehicleTypeData> vehicleTypeList = [];

  late NewVehicleEntryWidgetPresenterImpl _presenter;
  late ConnectionStatusSingleton connectionStatus;
  InputFieldResponse? inputFieldResponse;

  TextEditingController vehicalNumberController = TextEditingController();
  TextEditingController countyCodeController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController valuableNoteController = TextEditingController();
  TextEditingController valetDriverController = TextEditingController();
  TextEditingController parkingLocationController = TextEditingController();
  TextEditingController hookNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController vehicleColorController = TextEditingController();
  TextEditingController slotsController = TextEditingController();

  List<SlotsData> slotsList = [];

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
  bool signatureError = false;
  bool photoError = false;
  bool isParkedError = false;

  Color? errorColor;
  Color? blackColor;

  String mandetoryFieldError = "This field is mandatory";
  List<File?> imagesList = [];

  _NewVehicleEntryState() {
    _presenter = NewVehicleEntryWidgetPresenterImpl();
    _presenter.attachView(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();

    WidgetsBinding.instance!.addPostFrameCallback((_) => _presenter.initData());
  }

  @override
  Widget build(BuildContext context) {
    errorColor ??= Theme.of(context).colorScheme.error;
    blackColor ??= Colors.black;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Divider(
              thickness: 0.8,
            ),
            Visibility(
              visible:
                  (inputFieldResponse?.data?.form_permission?.hybrid ?? false),
              child: Row(
                children: [
                  const Text(
                    "Card",
                    style: TextStyle(fontSize: 16),
                  ),
                  Switch(
                    value: isSms,
                    onChanged: (value) {
                      onEntyTypeChanged(value);
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Theme.of(context).primaryColor,
                    inactiveTrackColor: Theme.of(context).primaryColorDark,
                  ),
                  const Text(
                    "SMS",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            isSms ? getSMSBasedLayout() : getCardBasedLayout(),
            Visibility(
              visible: inputFieldResponse != null,
              child: Row(
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
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      onPressed: () {
                        onSubmitClick();
                      },
                      fillColor: Colors.white,
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

  Widget getSMSBasedLayout() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_VEHICLE_SCAN),
              child: Expanded(
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      scanNumberPlate();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            child: isScanClicked
                                ? Image.asset(
                                    "images/Scan.png",
                                    height: 20,
                                  )
                                : Image.asset(
                                    "images/ActiveScan.png",
                                    height: 20,
                                  )),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          Strings.SCAN_NUMBER_PLATE,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_VEHICLE_NUMBER),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicalNumberController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. The functionality is maintained by
                      // the current suggestionsCallback logic (return [] if pattern.isEmpty).

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      // Must use the provided controller and focusNode on the inner TextFormField.
                      builder: (context, vehicalNumberController, focusNode) {
                        return TextFormField(
                          // Keep inputFormatters and maxLength on the TextFormField
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9]')),
                          ],
                          maxLength: 10,

                          controller:
                              vehicalNumberController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,

                          decoration: InputDecoration(
                            labelStyle: vehicleNumberError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleNumberError ? mandetoryFieldError : null,
                            counter:
                                const SizedBox(), // Replaces the counter from TextFieldConfiguration
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: 'KA01MM1234',
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        // Recreating the old SuggestionsBoxDecoration appearance (color and presumed scrollbar)
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.searchGuestDetails(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(
                                title: Text(suggestion.display_string ?? ""),
                              )
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        if (mounted) setState(() {});

                        // Suggestion logic preserved
                        SearchGuestData data = suggestion;
                        mobileNumberController.text = data.mobile_number ?? "";
                        nameController.text = data.customer_name ?? '';
                        selectedCarIndex =
                            int.tryParse(data.vehicle_type ?? '0') ?? 0;
                        vehicalNumberController.text =
                            data.vehicle_number ?? '';
                      },

                      // Validator is required for FormField widgets, even if it returns null
                      // As requested, this will be omitted, but note that a FormField **requires** a validator
                      // if you place it inside a Form widget. If not in a Form, it's safe to omit.

                      // validator: (value) {
                      //   return null;
                      // },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
            visible: checkSMSBaseField(Strings.MAND_VEHICLE_TYPE),
            child: const SizedBox(
              height: 10,
            )),
        Visibility(
          visible: checkSMSBaseField(Strings.MAND_VEHICLE_TYPE),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        Strings.VEHICLE_TYPE,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: vehicleTypeError,
                        child: Text(
                          mandetoryFieldError,
                          style: TextStyle(color: errorColor, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: vehicleTypeList.length,
                        itemBuilder: ((context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: InkWell(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      vehicleTypeError = false;
                                      selectedCarIndex =
                                          vehicleTypeList[index].id ?? 0;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      (vehicleTypeList[index].photos ?? ''),
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const SizedBox(
                                          height: 50,
                                          width: 50,
                                        );
                                      },
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(vehicleTypeList[index].name ?? '',
                                        style: (selectedCarIndex ==
                                                vehicleTypeList[index].id)
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
            ],
          ),
        ),
        Visibility(
          visible: checkSMSBaseField(Strings.MAND_VEHICLE_NAME) ||
              checkSMSBaseField(Strings.MAND_VEHICLE_COLOR),
          child: const SizedBox(
            height: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              //visible: false,
              visible: checkSMSBaseField(Strings.MAND_VEHICLE_NAME),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicleNameController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. The functionality is handled by the
                      // suggestionsCallback logic.

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      // Must use the provided controller and focusNode on the inner TextFormField.
                      builder: (context, vehicleNameController, focusNode) {
                        return TextFormField(
                          controller:
                              vehicleNameController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            if (vehicleNameError && text != '') {
                              vehicleNameError = false;
                              // Assuming setState is available in the surrounding State
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: vehicleNameError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleNameError ? mandetoryFieldError : null,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: Strings.VEHICLE_NAME,
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        // Recreating the old SuggestionsBoxDecoration appearance (white color)
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.suggestVehicleName(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(title: Text(suggestion.name ?? ""))
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        vehicleNameController.text = suggestion.name;
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_VEHICLE_NAME),
              child: const SizedBox(
                width: 5,
              ),
            ),
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_VEHICLE_COLOR),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicleColorController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. The functionality is handled by the
                      // suggestionsCallback logic.

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      // Must use the provided controller and focusNode on the inner TextFormField.
                      builder: (context, vehicleColorController, focusNode) {
                        return TextFormField(
                          controller:
                              vehicleColorController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            if (vehicleColorError && text != '') {
                              vehicleColorError = false;
                              // Assuming setState is available in the surrounding State
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: vehicleColorError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleColorError ? mandetoryFieldError : null,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: Strings.VEHICLE_COLOR,
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        // Recreating the old SuggestionsBoxDecoration appearance (white color)
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.suggestVehicleColor(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(title: Text(suggestion.color_name ?? ""))
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        vehicleColorController.text =
                            suggestion.color_name ?? '';
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: checkSMSBaseField(Strings.MAND_GUEST_MOBILE) ||
              checkSMSBaseField(Strings.MAND_GUEST_NAME),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.GUEST_DETAILS,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Visibility(
                    visible: checkSMSBaseField(Strings.MAND_GUEST_MOBILE),
                    child: Expanded(
                        child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: countyCodeController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "+91",
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
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: checkSMSBaseField(Strings.MAND_GUEST_MOBILE),
                    child: Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: mobileNumberController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            onChanged: (text) {
                              if (mobileeNumberError && text != '') {
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
                              hintText: Strings.MOBILE_NUMBER,
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
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: checkSMSBaseField(Strings.MAND_GUEST_NAME),
                    child: Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            onChanged: (text) {
                              if (nameError && text != '') {
                                nameError = false;

                                setState(() {});
                              }
                            },
                            decoration: InputDecoration(
                              labelStyle: nameError
                                  ? TextStyle(color: errorColor)
                                  : TextStyle(color: blackColor),
                              errorText: nameError ? mandetoryFieldError : null,
                              counter: const Offstage(),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: Strings.NAME_OPTIONAL,
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
                        )),
                  )
                ],
              ),
              Visibility(
                visible: checkSMSBaseField(Strings.MAND_GUEST_EMAIL),
                child: const SizedBox(
                  height: 10,
                ),
              ),
              Visibility(
                visible: checkSMSBaseField(Strings.MAND_GUEST_EMAIL),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (value != '' && emailError) {
                            emailError = false;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          labelStyle: emailError
                              ? TextStyle(color: errorColor)
                              : TextStyle(color: blackColor),
                          errorText: emailError ? mandetoryFieldError : null,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: Strings.USER_EMAIL,
                          hintStyle: const TextStyle(fontSize: 12),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Visibility(
                visible: checkSMSBaseField(Strings.MAND_GUEST_EMAIL),
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: checkSMSBaseField(Strings.MAND_SIGNATURE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if(signatureFile!=null){
                                return;
                              }
                              gotoSignatureScreen();
                            },
                            child: const Text(Strings.TAKE_SIGNATURE)),
                        signatureFile == null
                            ? const SizedBox()
                            : const SizedBox(
                                width: 20,
                              ),
                        signatureFile == null
                            ? const SizedBox()
                            : Image.file(
                                signatureFile!,
                                fit: BoxFit.fill,
                                height: 50,
                                width: 80,
                              ),
                      ],
                    ),
                    Visibility(
                        visible: signatureError,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(mandetoryFieldError,
                              style: TextStyle(color: errorColor)),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_VALUABLE),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.ANYTHING_VALUABLE,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all(BorderSide(
                                      color: isYesClicked
                                          ? Theme.of(context).primaryColor
                                          : Colors.black45)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    isYesClicked = true;
                                    isNoClicked = false;
                                    isValuable = "1";
                                    valuableError = false;
                                  });
                                }
                              },
                              child: const Text(
                                Strings.YES,
                                style: TextStyle(color: Colors.black54),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  color: isNoClicked
                                      ? Theme.of(context).primaryColor
                                      : Colors.black45)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  isNoClicked = true;
                                  isYesClicked = false;
                                  isValuable = "0";
                                  valuableError = false;
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
                                borderSide: BorderSide(color: Colors.black38)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: valuableError,
                        child: Text(
                          mandetoryFieldError,
                          style: TextStyle(color: errorColor),
                        ))
                  ],
                ),
              ),
            ),
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_PHOTOS),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.ADD_PHOTOS,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        direction: Axis.horizontal,
                        children: [
                          imagesList.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[0]!);
                                  },
                                  child: Image.file((imagesList[0]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : InkWell(
                                  onTap: () {
                                    openCamera();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                      size: 25,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 2
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[1]!);
                                  },
                                  child: Image.file((imagesList[1]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 1
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black54,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 3
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[2]!);
                                  },
                                  child: Image.file((imagesList[2]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 2
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black54, size: 25),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 4
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[3]!);
                                  },
                                  child: Image.file((imagesList[3]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 3
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black54, size: 25),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 5
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[4]!);
                                  },
                                  child: Image.file((imagesList[4]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 4
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black54, size: 25),
                                      ),
                                    ),
                        ],
                      ),
                      Visibility(
                          visible: photoError,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              mandetoryFieldError,
                              style: TextStyle(color: errorColor),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          Visibility(
            visible: checkSMSBaseField(Strings.MAND_VALET_DRIVER),
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.VALET_DRIVER,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: valetDriverController,
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              onTap: () {
                                _presenter.getDriverList();
                              },
                              decoration: InputDecoration(
                                labelStyle: valetDriverrError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: valetDriverrError
                                    ? mandetoryFieldError
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
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
                  ]),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Visibility(
            visible: checkSMSBaseField(Strings.MAND_PARKING_LOT),
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.PARKING_LOCATION,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: parkingLocationController,
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              onTap: () {
                                _presenter.getParkingLocationList();
                              },
                              decoration: InputDecoration(
                                labelStyle: parkingLocationError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: parkingLocationError
                                    ? mandetoryFieldError
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
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
                  ]),
            ),
          )
        ]),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: checkSMSBaseField(Strings.MAND_SLOTS),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.SLOTS,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TypeAheadField(
                                controller: slotsController,
                                // Renamed from noItemsFoundBuilder
                                emptyBuilder: (context) {
                                  return const SizedBox();
                                },
                                // getImmediateSuggestions is removed. It's implicitly handled since
                                // suggestionsCallback returns a list unconditionally.

                                // autoFlipDirection remains the same
                                autoFlipDirection: true,

                                // --- TextField Configuration Migration ---
                                // Replaced textFieldConfiguration with the required 'builder' property.
                                builder: (context, slotsController, focusNode) {
                                  return TextFormField(
                                    controller:
                                        slotsController, // Use the provided controller
                                    focusNode:
                                        focusNode, // Use the provided focusNode
                                    onChanged: (text) {
                                      if (slotsError && text != '') {
                                        slotsError = false;
                                        // Assuming setState is available in the surrounding State
                                        setState(() {});
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelStyle: slotsError
                                          ? TextStyle(color: errorColor)
                                          : TextStyle(color: blackColor),
                                      errorText: slotsError
                                          ? mandetoryFieldError
                                          : null,
                                      hintText: 'Type',
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
                                      counter:
                                          const Offstage(), // Hides the character counter
                                    ),
                                  );
                                },

                                // --- Suggestions Box Decoration Migration ---
                                // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                                decorationBuilder: (context, child) {
                                  // Recreating the old SuggestionsBoxDecoration appearance (white color)
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child:
                                        child, // The actual list of suggestions
                                  );
                                },

                                // suggestionsCallback remains the same (returns all items immediately)
                                suggestionsCallback: (pattern) {
                                  return slotsList;
                                },

                                // itemBuilder remains the same
                                itemBuilder: (context, dynamic suggestion) {
                                  return suggestion != null
                                      ? ListTile(
                                          title: Text(suggestion.name ?? ""),
                                        )
                                      : const SizedBox();
                                },

                                // Renamed from onSuggestionSelected to onSelected
                                onSelected: (dynamic suggestion) {
                                  slotsController.text = suggestion.name ?? "";
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
        Visibility(
          visible: checkSMSBaseField(Strings.MAND_SLOTS),
          child: const SizedBox(
            height: 10,
          ),
        ),
        Row(
          children: [
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_HOOK_NUMBER),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.HOOK_NUMBER,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  controller: hookNumberController,
                                  maxLength: 3,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (hookNumberError && value != '') {
                                      hookNumberError = false;
                                    }
                                    _presenter.checkHookNumber(value);
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: hookNumberError
                                        ? TextStyle(color: errorColor)
                                        : TextStyle(color: blackColor),
                                    // errorText: hookNumberError
                                    //     ? mandetoryFieldError
                                    //     : null,
                                    counter: const Offstage(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "00",
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark,
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
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Visibility(
              visible: checkSMSBaseField(Strings.MAND_NOTE),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.NOTES,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: notesController,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                if (notesError && text != '') {
                                  notesError = false;
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle: notesError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText:
                                    notesError ? mandetoryFieldError : null,
                                counter: const Offstage(),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: Strings.IF_ANY,
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
                  ],
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: hookMessage != null || hookNumberError,
                child: Text(
                    hookNumberError ? mandetoryFieldError : (hookMessage ?? ""),
                    style: isHookError || hookNumberError
                        ? const TextStyle(
                            color: Colors.red,
                          )
                        : TextStyle(
                            color: Colors.green[900],
                          ))),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Visibility(
          visible:
              checkSMSBaseField(Strings.MAND_IS_PARKED) && isParkedPermission,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            Strings.IS_VEHICLE_PARKED,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Switch.adaptive(
                              activeColor: Theme.of(context).primaryColor,
                              value: isParked,
                              onChanged: (value) => setState(() {
                                    isParked = value;
                                  }))
                        ],
                      ),
                      Visibility(
                          visible: isParkedError,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Text(mandetoryFieldError,
                                style: TextStyle(color: errorColor)),
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getCardBasedLayout() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: checkCardBaseField(Strings.MAND_HOOK_NUMBER),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.HOOK_NUMBER,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 45,
                                child: TextField(
                                  controller: hookNumberController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (hookNumberError && value != '') {
                                      hookNumberError = false;
                                      setState(() {});
                                    }
                                    _presenter.checkHookNumber(value);
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: hookNumberError
                                        ? TextStyle(color: errorColor)
                                        : TextStyle(color: blackColor),
                                    errorText: hookNumberError
                                        ? mandetoryFieldError
                                        : null,
                                    counter: const Offstage(),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "00",
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: hookMessage != null,
                                  child: Text((hookMessage ?? ""),
                                      style: isHookError
                                          ? const TextStyle(
                                              color: Colors.red,
                                            )
                                          : TextStyle(
                                              color: Colors.green[900],
                                            )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: checkCardBaseField(Strings.MAND_HOOK_NUMBER),
                child: const SizedBox(width: 10)),
            Visibility(
              visible: checkCardBaseField(Strings.MAND_VALUABLE),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.ANYTHING_VALUABLE,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(
                                    color: isYesClicked
                                        ? Theme.of(context).primaryColor
                                        : Colors.black45)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  isYesClicked = true;
                                  isNoClicked = false;
                                  isValuable = "1";
                                  valuableError = false;
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
                              side: MaterialStateProperty.all(BorderSide(
                                  color: isNoClicked
                                      ? Theme.of(context).primaryColor
                                      : Colors.black45)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  isNoClicked = true;
                                  isYesClicked = false;
                                  isValuable = "0";
                                  valuableError = false;
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
                      visible: isYesClicked,
                      child: SizedBox(
                        height: 45,
                        child: TextField(
                          controller: valuableNoteController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: Strings.ENTER_VALUABLE_THINGS,
                            hintStyle: const TextStyle(fontSize: 12),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: valuableError,
                        child: Text(mandetoryFieldError,
                            style: TextStyle(color: errorColor))),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility( 
              //visible: false,
              visible: checkCardBaseField(Strings.MAND_VEHICLE_SCAN),
              child: Expanded(
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          isScanClicked = true;
                           scanNumberPlate();
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            child: isScanClicked
                                ? Image.asset(
                                    "images/Scan.png",
                                    height: 20,
                                  )
                                : Image.asset(
                                    "images/ActiveScan.png",
                                    height: 20,
                                  )),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          Strings.SCAN_NUMBER_PLATE,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: checkCardBaseField(Strings.MAND_VEHICLE_SCAN),
              child: const SizedBox(
                width: 5,
              ),
            ),
            Visibility(
              visible: checkCardBaseField(Strings.MAND_VEHICLE_NUMBER),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicalNumberController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. Logic remains the same (suggestions only on non-empty pattern).

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      builder: (context, vehicalNumberController, focusNode) {
                        return TextFormField(
                          // Keep properties that define input behavior
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9]')),
                          ],
                          maxLength: 10,

                          controller:
                              vehicalNumberController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,

                          onChanged: (value) {
                            if (vehicleNumberError && value != '') {
                              vehicleNumberError = false;
                              // Assuming setState is available in the surrounding State
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: vehicleNumberError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleNumberError ? mandetoryFieldError : null,
                            counter:
                                const SizedBox(), // Replaces the counter from TextFieldConfiguration
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: 'KA01MM1234',
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.searchGuestDetails(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(
                                title: Text(suggestion.display_string ?? ""))
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        if (mounted) setState(() {});

                        // Suggestion logic preserved
                        // NOTE: You'll need access to SearchGuestData, selectedCarIndex, and the other controllers
                        // (mobileNumberController, nameController) outside this widget to use this logic fully.
                        SearchGuestData data = suggestion;
                        // mobileNumberController.text = data.mobile_number ?? ""; // Commented out as these controllers were not in the provided snippet's scope
                        // nameController.text = data.customer_name ?? '';
                        selectedCarIndex =
                            int.tryParse(data.vehicle_type ?? '0') ?? 0;
                        vehicalNumberController.text =  data.vehicle_number ?? '';
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_VEHICLE_TYPE),
          child: const SizedBox(
            height: 10,
          ),
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_VEHICLE_TYPE),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.VEHICLE_TYPE,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: vehicleTypeError,
                      child: Text(mandetoryFieldError,
                          style: TextStyle(color: errorColor))),
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: vehicleTypeList.length,
                        itemBuilder: ((context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: InkWell(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      selectedCarIndex =
                                          vehicleTypeList[index].id ?? 0;
                                    });
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.network(
                                      (vehicleTypeList[index].photos ?? ''),
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const SizedBox(
                                          height: 50,
                                          width: 50,
                                        );
                                      },
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(vehicleTypeList[index].name ?? '',
                                        style: (selectedCarIndex ==
                                                vehicleTypeList[index].id)
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
            ],
          ),
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_VEHICLE_NAME) ||
              checkCardBaseField(Strings.MAND_VEHICLE_COLOR),
          child: const SizedBox(
            height: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              //visible: false,
              visible: checkCardBaseField(Strings.MAND_VEHICLE_NAME),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicleNameController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. The functionality is handled by the
                      // suggestionsCallback logic.

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      builder: (context, vehicleNameController, focusNode) {
                        return TextFormField(
                          controller:
                              vehicleNameController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            if (vehicleNameError && value != '') {
                              vehicleNameError = false;
                              // Assuming setState is available in the surrounding State
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: vehicleNameError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleNameError ? mandetoryFieldError : null,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: Strings.VEHICLE_NAME,
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        // Recreating the old SuggestionsBoxDecoration appearance (white color)
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.suggestVehicleName(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(title: Text(suggestion.name ?? ""))
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        vehicleNameController.text = suggestion.name;
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: checkCardBaseField(Strings.MAND_VEHICLE_NAME),
              child: const SizedBox(
                width: 5,
              ),
            ),
            Visibility(
              visible: checkCardBaseField(Strings.MAND_VEHICLE_COLOR),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    child: TypeAheadField(
                      controller: vehicleColorController,
                      // Renamed from noItemsFoundBuilder
                      emptyBuilder: (context) {
                        return const SizedBox();
                      },
                      // getImmediateSuggestions is removed. The functionality is handled by the
                      // suggestionsCallback logic.

                      // autoFlipDirection remains the same
                      autoFlipDirection: true,

                      // --- TextField Configuration Migration ---
                      // Replaced textFieldConfiguration with the required 'builder' property.
                      builder: (context, vehicleColorController, focusNode) {
                        return TextFormField(
                          controller:
                              vehicleColorController, // Use the provided controller
                          focusNode: focusNode, // Use the provided focusNode
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            if (vehicleColorError && value != '') {
                              vehicleColorError = false;
                              // Assuming setState is available in the surrounding State
                              setState(() {});
                            }
                          },
                          decoration: InputDecoration(
                            labelStyle: vehicleColorError
                                ? TextStyle(color: errorColor)
                                : TextStyle(color: blackColor),
                            errorText:
                                vehicleColorError ? mandetoryFieldError : null,
                            counter: const SizedBox(),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            filled: true,
                            hintText: Strings.VEHICLE_COLOR,
                            fillColor: Colors.white,
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
                        );
                      },

                      // --- Suggestions Box Decoration Migration ---
                      // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                      decorationBuilder: (context, child) {
                        // Recreating the old SuggestionsBoxDecoration appearance (white color)
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: child, // The actual list of suggestions
                        );
                      },

                      // suggestionsCallback remains the same
                      suggestionsCallback: (pattern) {
                        if (pattern.isNotEmpty) {
                          return _presenter.suggestVehicleColor(pattern);
                        }
                        return [];
                      },

                      // itemBuilder remains the same
                      itemBuilder: (context, dynamic suggestion) {
                        return suggestion != null
                            ? ListTile(title: Text(suggestion.color_name ?? ""))
                            : const SizedBox();
                      },

                      // Renamed from onSuggestionSelected to onSelected
                      onSelected: (dynamic suggestion) {
                        vehicleColorController.text =
                            suggestion.color_name ?? '';
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_GUEST_MOBILE) ||
              checkCardBaseField(Strings.MAND_GUEST_NAME),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.GUEST_DETAILS,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Visibility(
                    visible: checkCardBaseField(Strings.MAND_GUEST_MOBILE),
                    child: Expanded(
                        child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: countyCodeController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "+91",
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
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: checkCardBaseField(Strings.MAND_GUEST_MOBILE),
                    child: Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 45,
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
                              hintText: Strings.MOBILE_NUMBER,
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
                        )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Visibility(
                    visible: checkCardBaseField(Strings.MAND_GUEST_NAME),
                    child: Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 45,
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
                              errorText: nameError ? mandetoryFieldError : null,
                              counter: const Offstage(),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: Strings.NAME_OPTIONAL,
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
                        )),
                  )
                ],
              ),
              Visibility(
                visible: checkCardBaseField(Strings.MAND_GUEST_EMAIL),
                child: const SizedBox(
                  height: 10,
                ),
              ),
              Visibility(
                visible: checkCardBaseField(Strings.MAND_GUEST_EMAIL),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          if (emailError && value != '') {
                            emailError = false;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          labelStyle: emailError
                              ? TextStyle(color: errorColor)
                              : TextStyle(color: blackColor),
                          errorText: emailError ? mandetoryFieldError : null,
                          filled: true,
                          fillColor: Colors.white,
                          hintText: Strings.USER_EMAIL,
                          hintStyle: const TextStyle(fontSize: 12),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Visibility(
                visible: checkCardBaseField(Strings.MAND_GUEST_EMAIL),
                child: const SizedBox(height: 10),
              ),
            ],
          ),
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_SIGNATURE),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                              if(signatureFile!=null){
                                return;
                              }
                        gotoSignatureScreen();
                      },
                      child: const Text(Strings.TAKE_SIGNATURE)),
                  signatureFile == null
                      ? const SizedBox()
                      : const SizedBox(
                          width: 20,
                        ),
                  signatureFile == null
                      ? const SizedBox()
                      : Image.file(
                          signatureFile!,
                          fit: BoxFit.fill,
                          height: 50,
                          width: 80,
                        ),
                ],
              ),
              Visibility(
                  visible: signatureError,
                  child: Text(
                    mandetoryFieldError,
                    style: TextStyle(color: errorColor),
                  ))
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: checkCardBaseField(Strings.MAND_PHOTOS),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.ADD_PHOTOS,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        direction: Axis.horizontal,
                        children: [
                          imagesList.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[0]!);
                                  },
                                  child: Image.file((imagesList[0]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : InkWell(
                                  onTap: () {
                                    openCamera();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(3)),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.black54,
                                      size: 25,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 2
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[1]!);
                                  },
                                  child: Image.file((imagesList[1]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 1
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black26,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 3
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[2]!);
                                  },
                                  child: Image.file((imagesList[2]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 2
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black26, size: 25),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 4
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[3]!);
                                  },
                                  child: Image.file((imagesList[3]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 3
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black26, size: 25),
                                      ),
                                    ),
                          const SizedBox(
                            width: 10,
                          ),
                          imagesList.length >= 5
                              ? InkWell(
                                  onTap: () {
                                    showPhoto(imagesList[0]!);
                                  },
                                  child: Image.file((imagesList[0]!),
                                      fit: BoxFit.fill, height: 25, width: 25),
                                )
                              : imagesList.length != 4
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        openCamera();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border:
                                              Border.all(color: Colors.black12),
                                        ),
                                        child: const Icon(Icons.add,
                                            color: Colors.black26, size: 25),
                                      ),
                                    ),
                        ],
                      ),
                      Visibility(
                          visible: photoError,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              mandetoryFieldError,
                              style: TextStyle(color: errorColor),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          Visibility(
            visible: checkCardBaseField(Strings.MAND_VALET_DRIVER),
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.VALET_DRIVER,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: valetDriverController,
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              onTap: () {
                                _presenter.getDriverList();
                              },
                              decoration: InputDecoration(
                                labelStyle: valetDriverrError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: valetDriverrError
                                    ? mandetoryFieldError
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
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
                  ]),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Visibility(
            visible: checkCardBaseField(Strings.MAND_PARKING_LOT),
            child: Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.PARKING_LOCATION,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: parkingLocationController,
                              textInputAction: TextInputAction.next,
                              readOnly: true,
                              onTap: () {
                                _presenter.getParkingLocationList();
                              },
                              decoration: InputDecoration(
                                labelStyle: parkingLocationError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText: parkingLocationError
                                    ? mandetoryFieldError
                                    : null,
                                fillColor: Colors.white,
                                filled: true,
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
                  ]),
            ),
          )
        ]),
        const SizedBox(
          height: 10,
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_SLOTS),
          child: Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        Strings.SLOTS,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                            height: 45,
                            child: TypeAheadField(
                              controller: slotsController,
                              // Renamed from noItemsFoundBuilder
                              emptyBuilder: (context) {
                                return const SizedBox();
                              },
                              // getImmediateSuggestions is removed. Since suggestionsCallback returns slotsList
                              // unconditionally, the behavior (suggestions appear on focus) is implicitly maintained.

                              // autoFlipDirection remains the same
                              autoFlipDirection: true,

                              // --- TextField Configuration Migration ---
                              // Replaced textFieldConfiguration with the required 'builder' property.
                              builder: (context, slotsController, focusNode) {
                                return TextFormField(
                                  controller:
                                      slotsController, // Use the provided controller
                                  focusNode:
                                      focusNode, // Use the provided focusNode
                                  onChanged: (text) {
                                    if (slotsError && text != '') {
                                      slotsError = false;
                                      // Assuming setState is available in the surrounding State
                                      setState(() {});
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelStyle: slotsError
                                        ? TextStyle(color: errorColor)
                                        : TextStyle(color: blackColor),
                                    errorText:
                                        slotsError ? mandetoryFieldError : null,
                                    hintText: 'Type',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black38)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                    counter:
                                        const Offstage(), // Hides the character counter
                                  ),
                                );
                              },

                              // --- Suggestions Box Decoration Migration ---
                              // suggestionsBoxDecoration is gone, replaced by decorationBuilder.
                              decorationBuilder: (context, child) {
                                // Recreating the old SuggestionsBoxDecoration appearance (white color)
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child:
                                      child, // The actual list of suggestions
                                );
                              },

                              // suggestionsCallback remains the same (returns all items immediately)
                              suggestionsCallback: (pattern) {
                                return slotsList;
                              },

                              // itemBuilder remains the same
                              itemBuilder: (context, dynamic suggestion) {
                                return suggestion != null
                                    ? ListTile(
                                        title: Text(suggestion.name ?? ""),
                                      )
                                    : const SizedBox();
                              },

                              // Renamed from onSuggestionSelected to onSelected
                              onSelected: (dynamic suggestion) {
                                slotsController.text = suggestion.name ?? "";
                              },
                            ),
                          )),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
        Visibility(
          visible: checkCardBaseField(Strings.MAND_SLOTS),
          child: const SizedBox(
            height: 10,
          ),
        ),
        Row(
          children: [
            Visibility(
              visible: checkCardBaseField(Strings.MAND_NOTE),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      Strings.NOTES,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: notesController,
                              textInputAction: TextInputAction.next,
                              onChanged: (text) {
                                if (text != '' && notesError) {
                                  notesError = false;
                                  setState(() {});
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle: notesError
                                    ? TextStyle(color: errorColor)
                                    : TextStyle(color: blackColor),
                                errorText:
                                    notesError ? mandetoryFieldError : null,
                                fillColor: Colors.white,
                                filled: true,
                                hintText: Strings.IF_ANY,
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
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Visibility(
          visible:
              checkCardBaseField(Strings.MAND_IS_PARKED) && isParkedPermission,
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        Strings.IS_VEHICLE_PARKED,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      Switch.adaptive(
                          activeColor: Theme.of(context).primaryColor,
                          value: isParked,
                          onChanged: (value) => setState(() {
                                isParked = value;
                              }))
                    ],
                  ),
                  Visibility(
                      visible: isParkedError,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Text(mandetoryFieldError,
                            style: TextStyle(color: errorColor)),
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool getEntryType() {
    return isSms;
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
  File? getSignatureFile() {
    return signatureFile;
  }

  @override
  bool isValuableYesSelected() {
    return isYesClicked;
  }

  @override
  bool isValuableNoSelected() {
    return isNoClicked;
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
  bool isHookNumberError() {
    return isHookError;
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
  bool isVehicleParked() {
    return isParked;
  }

  @override
  List<File?> getUploadedPhoto() {
    return imagesList;
  }

  @override
  String getSlots() {
    // TODO: implement getSlots
    return slotsController.text;
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
    if(!mounted){
  return;
    }
      
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
      );
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
  void dispose() {
    // TODO: implement dispose
    vehicalNumberController.dispose();
    countyCodeController.dispose();
    mobileNumberController.dispose();
    nameController.dispose();
    emailController.dispose();
    valuableNoteController.dispose();
    valetDriverController.dispose();
    parkingLocationController.dispose();
    hookNumberController.dispose();
    notesController.dispose();
    vehicleNameController.dispose();
    vehicleColorController.dispose();
    slotsController.dispose();
    super.dispose();
  }

  @override
  void onInputFieldResponse(InputFieldResponse inputFieldResponse) {
    // TODO: implement onInputFieldResponse
    this.inputFieldResponse = inputFieldResponse;
    if (this.inputFieldResponse?.data?.form_permission?.hybrid ?? false) {
      isSms = true;
    } else if (this.inputFieldResponse?.data?.form_permission?.sms_based ??
        false) {
      isSms = true;
    } else {
      isSms = false;
    }
    if (mounted) setState(() {});
  }

  bool checkCardBaseField(String fieldName) {
    return inputFieldResponse?.data?.card_based?.card_input_permission
            ?.contains(fieldName.toLowerCase()) ??
        false;
  }

  bool checkSMSBaseField(String fieldName) {
    return inputFieldResponse?.data?.sms_based?.sms_input_permission
            ?.contains(fieldName.toLowerCase()) ??
        false;
  }

  @override
  void setVehicleType(List<VehicleTypeData> vehicleTypeList) {
    // TODO: implement setVehicleType
    this.vehicleTypeList = vehicleTypeList;

    if (mounted) setState(() {});
  }

  void onEntyTypeChanged(bool value) {
    isSms = value;
    clearData();
  }

  @override
  void clearData() {
    vehicalNumberController.text = '';
    countyCodeController.text = '';
    mobileNumberController.text = '';
    nameController.text = '';
    emailController.text = '';
    valuableNoteController.text = '';
    valetDriverController.text = '';
    parkingLocationController.text = '';
    hookNumberController.text = '';
    notesController.text = '';
    isYesClicked = false;
    isNoClicked = false;
    selectedCarIndex = -1;
    isParked = true;
    hookMessage = null;
    isHookError = false;
    signatureFile = null;
    driverListData = null;
    parkingLocationData = null;
    uploadedPhoto.clear();
    isValuable = '';
    vehicleColorController.text = '';
    vehicleNameController.text = '';
    slotsController.text = '';
    imagesList.clear();

    vehicleNumberError = false;
    mobileeNumberError = false;
    emailError = false;
    nameError = false;
    valuableError = false;
    valetDriverrError = false;
    parkingLocationError = false;
    hookNumberError = false;
    notesError = false;
    vehicleTypeError = false;
    slotsError = false;
    vehicleNameError = false;
    vehicleColorError = false;
    signatureError = false;
    photoError = false;
    isParkedError = false;
    if (mounted) setState(() {});
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
      parkingLocationController.text =
          "${(parkingLocationData?.name ?? '')} (${(parkingLocationData?.capacity ?? '')})";
      slotsController.text = '';
      parkingLocationError = false;
      setState(() {});
      _presenter.onParkingLocationSelected(parkingLocationData);
    }
  }

  @override
  void setHookNumberResponse(CheckHookNumberResponse response) {
    // TODO: implement setHookNumberResponse
    if (response.status == 0) {
      isHookError = true;
    } else {
      isHookError = false;
    }
    hookMessage = response.message;
    if (mounted) setState(() {});
  }

  Future<void> openCamera() async {
    showProgress();
    final XFile? photo = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1280,
        maxWidth: 720,
        imageQuality: 40);
    hideProgress();
    // if (photo != null) {
    //   handlePhotoValue(photo.path);
    // }
    if (photo != null) {
      File f = File(photo.path);
      imagesList.add(f);
      setState(() {});
    }
  }

  Future<void> scanNumberPlate() async {
    showProgress();
    final XFile? photo = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1280,
        maxWidth: 720,
        imageQuality: 40);
    hideProgress();
    // if (photo != null) {
    //   handlePhotoValue(photo.path);
    // }
    if (photo != null) {
      _presenter.scanNumberPlate(photo);
    }
  }

  @override
  void onNumberPlateScan(ScanNumberPlateResponse response) {
    vehicalNumberController.text = response.vehicle_number ?? "";
    vehicleNameError = false;
    setState(() {});
  }

  @override
  void setDriverListResponse(List<DriverListData> data) {
    // TODO: implement setParkingLocationResponse

    showDialog(context: context, builder: (context) => SelectDriverDialog(data))
        .then((value) => handleDriverListClick(value));
  }

  @override
  void handleDriverListClick(value) {
    if (value != null) {
      driverListData = value;
      valetDriverController.text = (driverListData?.name ?? '');
      valetDriverrError = false;
      setState(() {});
    }
  }

  void gotoSignatureScreen() {
    Navigator.of(context)
        .pushNamed(SignatureScreen.routeName)
        .then((value) => handleSigatureValue(value));
  }

  void handleSigatureValue(value) {
    if (value != null && value is File) {
      signatureFile = value;
      signatureError = false;
      if (mounted) setState(() {});
    }
  }

  void onSubmitClick() {
    if (isSms) {
      _presenter.callSmsBasedAPI();
    } else {
      _presenter.callCardBasedAPI();
    }
  }

  @override
  void onTransactionCompleted() {
    widget.onVehicleAdded();
  }

  void refresh() {
    clearData();
    _presenter.initData();
  }

  @override
  void setSlotsList(List<SlotsData> slotsList) {
    this.slotsList = slotsList;
    setState(() {});
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
      bool vehicleColorError,
      bool signatureError,
      bool photoError,
      bool isParkedError) {
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
    this.signatureError = signatureError;
    this.photoError = photoError;
    this.isParkedError = isParkedError;

    setState(() {});
  }

  void showPhoto(File f) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
            scale: curve,
            child: f.path != "" ? ImageDialog(f) : const SizedBox());
      },
      transitionDuration: const Duration(milliseconds: 300),
    ).then((value) => deletePhoto(value));
  }

  void deletePhoto(value) {
    if (value != null && value is File) {
      imagesList.remove(value);
      if (mounted) setState(() {});
    }
  }

  @override
  void setPermission(bool isParked) {
    // TODO: implement setPermission
    isParkedPermission = isParked;
  }
}
