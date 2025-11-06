import 'package:valet_app/Data/Request/LoginRequest.dart';

abstract class LoginScreenPresenter {
  void initData();

  void onLoginClick(LoginRequest request);

  void getPlayerId();
}
