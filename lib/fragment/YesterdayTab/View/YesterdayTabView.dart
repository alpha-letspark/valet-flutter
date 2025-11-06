import '../../../Data/Response/HistoryData.dart';

abstract class YesterdayTabView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setHistoryData(List<HistoryData> data);
}
