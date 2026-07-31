import 'package:valet_app/Data/Response/ExitListData.dart';

abstract class ExitTabView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setExitDataList(List<ExitListData> exitList);

  void showDriver(bool isDriver);
}
