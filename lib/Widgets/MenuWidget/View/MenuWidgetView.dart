abstract class MenuWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void showUploadPhotoCount(int count);

  void setPermission(bool isHistory, bool isSetting, bool isParked);
}
