import 'package:image_picker/image_picker.dart';
import 'package:valet_app/Data/Response/VehicleColorData.dart';

import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/SearchGuestData.dart';
import '../../../Data/Response/VehicleNameData.dart';

abstract class NewVehicleEntryWidgetPresenter {
  void initData();

  void getParkingLocationList();

  void checkHookNumber(String number);

  Future<List<SearchGuestData>> searchGuestDetails(String search);

  void scanNumberPlate(XFile photo);

  void getDriverList();

  void callSmsBasedAPI();

  void callCardBasedAPI();

  Future<List<VehicleNameData>> suggestVehicleName(String search);

  Future<List<VehicleColorData>> suggestVehicleColor(String search);

  void onParkingLocationSelected(ParkingLocationData? parkingLocationData);
}
