import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";
  var serverErrorData;

  ServerError.withError(serverErrorData, {required DioException error}) {
    _handleError(error);
    this.serverErrorData = serverErrorData;
  }

  getServerError() {
    return serverErrorData;
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        _errorCode = error.response?.statusCode;
        _errorMessage = "Connection timeout";
        // TODO: Handle this case.
        break;
      case DioExceptionType.sendTimeout:
        _errorCode = error.response?.statusCode;
        _errorMessage = "Connection timeout";
        // TODO: Handle this case.
        break;
      case DioExceptionType.receiveTimeout:
        _errorCode = error.response?.statusCode;
        _errorMessage = "Receive timeout in connection";
        // TODO: Handle this case.
        break;
      case DioExceptionType.badCertificate:
        _errorCode = error.response?.statusCode;
        _errorMessage = "bad Certificate";
        // TODO: Handle this case.
        break;
      case DioExceptionType.badResponse:
        // TODO: Handle this case.
        _errorCode = error.response?.statusCode;
        _errorMessage = "Something went wrong";
        break;
      case DioExceptionType.cancel:
        _errorCode = error.response?.statusCode;
        _errorMessage = "Request was cancelled";
        // TODO: Handle this case.
        break;
      case DioExceptionType.connectionError:
        _errorCode = error.response?.statusCode;
        _errorMessage = "Receive timeout in send request";
        // TODO: Handle this case.
        break;
      case DioExceptionType.unknown:
        // TODO: Handle this case.
        _errorCode = error.response?.statusCode;
        _errorMessage = "Something went wrong";
        break;
    }
    return _errorMessage;
  }
}
