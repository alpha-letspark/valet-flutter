import 'package:valet_app/Data/Response/SettingData.dart';
import 'package:valet_app/Data/Response/SignatureData.dart';

abstract class SignatureScreenView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setSignatureData(SignatureData? data);
}
