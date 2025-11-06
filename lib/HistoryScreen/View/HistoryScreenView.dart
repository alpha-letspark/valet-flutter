import '../../Data/Response/HistoryCountData.dart';

abstract class HistoryScreenView {
  void showProgress();
  void hideProgress();
  Future<bool> isOnline();
  void setHistoryCount(HistoryCountData? countData);
}
