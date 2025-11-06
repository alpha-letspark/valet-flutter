import 'package:valet_app/Data/Response/ExitByHNData.dart';

import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/ParkingLocationData.dart';

abstract class ExitByHNWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setParkingLocationResponse(List<ParkingLocationData> data);

  void onDataUpdated();

  DriverListData? getDriverListData();

  void setDriverListResponse(List<DriverListData> data);

  void showPinDialog(ExitByHNData data, String masterKey, bool shouldShowPin);
}
