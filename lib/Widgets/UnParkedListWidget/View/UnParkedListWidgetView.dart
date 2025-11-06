import 'package:valet_app/Data/Response/SlotsData.dart';

import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/VehicleTypeData.dart';

abstract class UnParkedListWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setVehicleType(List<VehicleTypeData> data);

  void setParkingLocationResponse(List<ParkingLocationData> data);

  void setDriverListResponse(List<DriverListData> data);

  void setVisibleFieldList(List<String> visible);

  void setMandatoryFieldList(List<String> mandatory);

  String getVehicleNumber();

  int getVehicleType();

  String getGuestMobileNumber();

  String getGuestName();

  String getGuestEmail();

  String isValueableText();

  DriverListData? getDriverData();

  ParkingLocationData? getParkingLocationData();

  String getHookNumber();

  String getNotes();

  List<String> getUploadedPhoto();

  String isValuableSelected();

  void onTranscationSuccess();

  String getSlots();

  String getVehicleName();

  String getVehicleColor();

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
      bool vehicleColorError);
}
