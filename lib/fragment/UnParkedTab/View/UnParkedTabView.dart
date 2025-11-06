import 'package:valet_app/Data/Response/UnparkedListData.dart';

abstract class UnParkedTabview {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setUnparekedListItem(List<UnparkedListData> data);
}
