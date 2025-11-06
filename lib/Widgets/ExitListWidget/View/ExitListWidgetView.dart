import 'package:valet_app/Data/Response/ExitListData.dart';

import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/VehicleTypeData.dart';

abstract class ExitListWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setDriverListResponse(List<DriverListData> data);

  void setVisibleFieldList(List<String> visible);

  void setMandatoryFieldList(List<String> mandatory);

  DriverListData? getDriverData();

  void onTranscationSuccess();

  void showPinDialog(ExitListData data, String masterKey, bool shouldShowPin);
}
