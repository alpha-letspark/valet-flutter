import 'package:valet_app/Data/Response/GuestRequestData.dart';

abstract class GuestRequestTabView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setGuestRequest(List<GuestRequestData> data);

  void showDriver(bool showDriver);
}
