abstract class HomeScreenView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setPermissions(bool isNewEntry, bool isCheckIn, bool isCheckOut);

  void handleNotification();
}
