import 'package:valet_app/Data/ServerError.dart';

class BaseResponse<T> {
  ServerError? _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  int get errorCode => _error?.getErrorCode() ?? 0;

  String get getException => _error?.getErrorMessage() ?? "";

  ServerError? get serverError => _error;
}
