import 'dart:io';

import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Data/Response/ScanNumberPlateResponse.dart';
import 'package:valet_app/Data/Response/SlotsData.dart';

import '../../../Data/Response/CheckHookNumberResponse.dart';
import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/InputFieldResponse.dart';
import '../../../Data/Response/VehicleTypeData.dart';

abstract class NewVehicleEntryWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void onInputFieldResponse(InputFieldResponse inputFieldResponse);

  void setVehicleType(List<VehicleTypeData> data);

  void setParkingLocationResponse(List<ParkingLocationData> data);

  void setHookNumberResponse(CheckHookNumberResponse response);

  void onNumberPlateScan(ScanNumberPlateResponse response);

  void setDriverListResponse(List<DriverListData> data);

  bool getEntryType();

  String getVehicleNumber();

  int getVehicleType();

  String getGuestMobileNumber();

  String getGuestName();

  String getGuestEmail();

  File? getSignatureFile();

  bool isValuableYesSelected();

  bool isValuableNoSelected();

  String isValueableText();

  DriverListData? getDriverData();

  ParkingLocationData? getParkingLocationData();

  bool isHookNumberError();

  String getHookNumber();

  String getNotes();

  String getVehicleName();

  String getVehicleColor();

  String getSlots();

  bool isVehicleParked();

  List<File?> getUploadedPhoto();

  String isValuableSelected();

  void clearData();

  void onTransactionCompleted();

  void setSlotsList(List<SlotsData> slotsList);

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
      bool isParkedError);

  void setPermission(bool isParked);

  void handleDriverListClick(value);
}
