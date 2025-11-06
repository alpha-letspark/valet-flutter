import '../../../Data/Response/EntryMenuNumberResponse.dart';

abstract class CheckInOutWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setMenuNumberResponse(EntryMenuNumberResponse response);

  void setPermissions(bool isCheckIn, bool isCheckOut);
}
