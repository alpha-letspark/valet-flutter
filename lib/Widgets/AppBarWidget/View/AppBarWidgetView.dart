import 'package:valet_app/Data/Response/LoginResponse.dart';

abstract class AppBarWidgetView {
  void setDataAndPermission(LoginResponse? loginResponse, bool isNewEntry);
}
