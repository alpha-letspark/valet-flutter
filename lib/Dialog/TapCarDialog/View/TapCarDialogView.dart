import '../../../Data/Response/ParkingDetailsData.dart';
import '../../../Data/Response/ParkingLocationData.dart';

abstract class TapCarDialogView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setParkingLocationResponse(List<ParkingLocationData> data);

  ParkingLocationData? getParkingLocation();

  ParkingDetailsData getParkingDetailsData();

  void onTransactionUpdated();

  void showPinDialog(
      ParkingDetailsData data, String masterKey, bool shouldShowPin);

  void onTranscationSuccess();
}
