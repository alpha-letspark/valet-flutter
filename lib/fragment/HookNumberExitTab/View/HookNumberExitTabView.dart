import 'package:valet_app/Data/Response/ExitByHNData.dart';

abstract class HookNumberExitTabView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setResponse(List<ExitByHNData> exitByHNList);

  void showDriver(bool isDriver);
}
