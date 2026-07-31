import 'package:valet_app/Data/Response/SettingData.dart';

abstract class SettingScreenView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setSettingData(SettingData? data);
}
