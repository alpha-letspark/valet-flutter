import 'package:valet_app/Data/Response/LoginResponse.dart';

abstract class LoginScreenView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void onLoginSuccess(LoginResponse response);

  void askPermission();
}
