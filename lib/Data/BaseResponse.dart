import 'package:valet_app/Data/ServerError.dart';

class BaseResponse<T> {
  late ServerError _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  get errorCode {
    return _error.getErrorCode();
  }

  get getException {
    return _error.getErrorMessage();
  }

  get getServerError {
    return _error.serverErrorData;
  }
}
