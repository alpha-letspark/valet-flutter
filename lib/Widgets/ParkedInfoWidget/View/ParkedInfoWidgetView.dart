import 'package:valet_app/Data/Response/ParkingDetailsData.dart';

import '../../../Data/Response/ParkedInfoData.dart';
import '../../../Data/Response/ParkingLocationData.dart';

abstract class ParkedInfoWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setParkingLocationResponse(
      List<ParkingLocationData> locationList, List<ParkedInfoData> parkingList);

  void onCarDetails(ParkingDetailsData? data);
}
