import 'package:valet_app/Data/Response/SummaryData.dart';

abstract class SummaryScreenView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setSummaryData(List<SummaryData> summaryData);
}
