import 'package:valet_app/Data/Response/VehicleColorData.dart';
import 'package:valet_app/Data/Response/VehicleNameData.dart';

import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/UnparkedListData.dart';

abstract class UnParkedListWidgetPresenter {
  void initData(UnparkedListData data);

  void getVehicleType();

  void getParkingLocationList();

  void getDriverList();

  void onSubmitClick(UnparkedListData data);

  void onParkingLocationSelected(ParkingLocationData? parkingLocationData);

  Future<List<VehicleNameData>> suggestVehicleName(String search);

  Future<List<VehicleColorData>> suggestVehicleColor(String search);
}
