import 'dart:io';

import 'package:dio/dio.dart';
import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/ImageUploadData.dart';
import 'package:valet_app/Data/Request/AccpetGuestRequest.dart';
import 'package:valet_app/Data/Request/AssignDriverRequest.dart';
import 'package:valet_app/Data/Request/CardBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/CardBasedUpdateRequest.dart';
import 'package:valet_app/Data/Request/ExitByHNRequest.dart';
import 'package:valet_app/Data/Request/ExitVehicleRequest.dart';
import 'package:valet_app/Data/Request/LoginRequest.dart';
import 'package:valet_app/Data/Request/ParkedLocationUpdate.dart';
import 'package:valet_app/Data/Request/RolePermissionRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedUpdateRequest.dart';
import 'package:valet_app/Data/Request/SearchGuestRequest.dart';
import 'package:valet_app/Data/Request/SettingRequest.dart';
import 'package:valet_app/Data/Response/CheckHookNumberResponse.dart';
import 'package:valet_app/Data/Response/DriverListResponse.dart';
import 'package:valet_app/Data/Response/ExitByHNResponse.dart';
import 'package:valet_app/Data/Response/ExitListResponse.dart';
import 'package:valet_app/Data/Response/GuestRequestResponse.dart';
import 'package:valet_app/Data/Response/HistoryCountResponse.dart';
import 'package:valet_app/Data/Response/HistoryResponse.dart';
import 'package:valet_app/Data/Response/InputFieldResponse.dart';
import 'package:valet_app/Data/Response/LPBaseResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/NewVehicleEntryResponse.dart';
import 'package:valet_app/Data/Response/ParkedInfoResponse.dart';
import 'package:valet_app/Data/Response/ParkingDetailsResponse.dart';
import 'package:valet_app/Data/Response/ParkingLocationResponse.dart';
import 'package:valet_app/Data/Response/PermissionResponse.dart';
import 'package:valet_app/Data/Response/RolePermissionResponse.dart';
import 'package:valet_app/Data/Response/ScanNumberPlateResponse.dart';
import 'package:valet_app/Data/Response/SearchGuestResponse.dart';
import 'package:valet_app/Data/Response/SettingResponse.dart';
import 'package:valet_app/Data/Response/SignatureResponse.dart';
import 'package:valet_app/Data/Response/SlotsResponse.dart';
import 'package:valet_app/Data/Response/SummaryResponse.dart';
import 'package:valet_app/Data/Response/UnparkedListResponse.dart';
import 'package:valet_app/Data/Response/UpdateVehicleEntryResponse.dart';
import 'package:valet_app/Data/Response/VehicleColorResponse.dart';
import 'package:valet_app/Data/Response/VehicleNameResponse.dart';
import 'package:valet_app/Data/Response/VehicleTypeResponse.dart';
import 'package:valet_app/Database/DatabaseHelper.dart';

import '../Data/Request/CheckHookNumberRequest.dart';
import '../Data/Request/HistroryCountRequest.dart';
import '../Data/Response/EntryMenuNumberResponse.dart';
import '../Data/Response/ExitVehicleResponse.dart';
import '../Data/Response/PostExitByHNResponse.dart';
import '../Data/Response/UploadSignatureResponse.dart';
import '../Data/ServerError.dart';
import 'ApiClient.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApiClientImpl {
  var client;
  LoginResponse? response;
  List<String>? viewPermission;

  static final ApiClientImpl _singleton = new ApiClientImpl._internal();

  factory ApiClientImpl() {
    return _singleton;
  }

  ApiClientImpl._internal();

  initClient() {
    if (client == null) {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 15);
      dio.options.receiveTimeout = const Duration(minutes: 15);
      dio.options.sendTimeout = const Duration(minutes: 15);
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) => requestInterceptor(options, handler),
          onResponse: (response, handler) =>
              responseInterceptor(response, handler),
          onError: (dioError, handler) => errorInterceptor(dioError, handler)));

      // onRequest: (RequestOptions options) => requestInterceptor(options),
      // onResponse: (Response response) => responseInterceptor(response),
      // onError: (DioError dioError) => errorInterceptor(dioError)));

      client = ApiClient(dio);
    }
  }

  void setLoginData(LoginResponse response) {
    this.response = response;
  }

  LoginResponse? getLoginData() {
    return response;
  }

  void setViewRoles(List<String> viewPermission) {
    this.viewPermission = viewPermission;
  }

  List<String> getViewRoles() {
    return viewPermission ?? [];
  }

  void requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (response != null) {
      options.headers["Authorization"] =
          "${response!.token_type} ${response!.access_token}";
    }
    options.headers["Content-Type"] = "application/json";

    if (options.headers != null) {
      printMessage(options.headers);
    }
    if (options.uri != null) {
      printMessage(options.uri);
    }

    await Future.delayed(Duration(milliseconds: 100));
    if (options.data != null && options.data != '') {
      if (options.data is FormData) {
        handler.next(options);
        return;
      }
      var data = json.encode(options.data);
      if (data != "{}") printMessage(data);
      if (data != "{}") {}
    }
    handler.next(options);
  }

  void responseInterceptor(
      Response options, ResponseInterceptorHandler handler) {
    if (options.data != null && options.data != '') {
      if (options.data.toString().contains("UserDto")) {
        handler.next(options);
        return;
      }
      var data = json.encode(options.data);
      printMessage(data);
      //_serviceLog!.writeServiceLog(data);
    }
    handler.next(options);
  }

  void errorInterceptor(DioError options, ErrorInterceptorHandler handler) {
    // if (_serviceLog == null) {
    //   _serviceLog = ServiceLog();
    // }
    // _serviceLog!.writeServiceLog(options.message);
    // _serviceLog!.writeServiceLog(options.response == null
    //     ? ""
    //     : options.response!.data == null
    //         ? ""
    //         : options.response!.data.toString());
    handler.next(options);
  }

  clearClint() {
    client = null;
  }

  void printMessage(data) {
    if (data != null && !kReleaseMode) print(data);
  }

  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    LoginResponse? response;
    try {
      response = await client.login(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  //input_permission
  Future<BaseResponse<InputFieldResponse>> getInputPermissionData(
      String clientId) async {
    InputFieldResponse? response;
    try {
      response = await client.getInputPermissionData(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<VehicleTypeResponse>> getVehicleType(
      String clientId) async {
    VehicleTypeResponse? response;
    try {
      response = await client.getVehicleType(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ParkingLocationResponse>> getParkingLocation(
      String clientId) async {
    ParkingLocationResponse? response;
    try {
      response = await client.getParkingLocation(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<CheckHookNumberResponse>> checkHookNumber(
      CheckHookNumberRequest request) async {
    CheckHookNumberResponse? response;
    try {
      response = await client.checkHookNumber(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SettingResponse>> getSettingData(String clientId) async {
    SettingResponse? response;
    try {
      response = await client.getSettingData(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SettingResponse>> updateSetting(
      SettingRequest request) async {
    SettingResponse? response;
    try {
      response = await client.updateSetting(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SearchGuestResponse>> searchGuestDetails(
      SearchGuestRequest request) async {
    SearchGuestResponse? response;
    try {
      response = await client.searchGuestDetails(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ScanNumberPlateResponse>> scanNumberPlate(
      String userId, String clientId, File file) async {
    ScanNumberPlateResponse? response;
    try {
      response = await client.scanNumberPlate(userId, clientId, file);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<DriverListResponse>> getDriverList(
      String clientId) async {
    DriverListResponse? response;
    try {
      response = await client.getDriverList(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<HistoryResponse>> getHistoryData(
      String clientId, String date) async {
    HistoryResponse? response;
    try {
      response = await client.getHistoryData(clientId, date);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ParkedInfoResponse>> getParkingListInformation(
      String clientId) async {
    ParkedInfoResponse? response;
    try {
      response = await client.getParkingListInformation(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<NewVehicleEntryResponse>> entryCardBased(
      CardBasedEntryRequest request) async {
    NewVehicleEntryResponse? response;
    try {
      response = await client.entryCardBased(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<NewVehicleEntryResponse>> entrySMSBased(
      SMSBasedEntryRequest request) async {
    NewVehicleEntryResponse? response;
    try {
      response = await client.entrySMSBased(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SignatureResponse>> getSignatureTC(
      String clientId) async {
    SignatureResponse? response;
    try {
      response = await client.getSignatureTC(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ParkingDetailsResponse>> getParkingDetails(
      String transactionId) async {
    ParkingDetailsResponse? response;
    try {
      response = await client.getParkingDetails(transactionId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<EntryMenuNumberResponse>> getMenuNumber(
      String clientId, String userId) async {
    EntryMenuNumberResponse? response;
    try {
      response = await client.getMenuNumber(clientId, userId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<UnparkedListResponse>> getUnParkedVehicleList(
      String clientId) async {
    UnparkedListResponse? response;
    try {
      response = await client.getUnParkedVehicleList(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<UpdateVehicleEntryResponse>> updateCardBased(
      CardBasedUpdateRequest request) async {
    UpdateVehicleEntryResponse? response;
    try {
      response = await client.updateCardBased(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<UpdateVehicleEntryResponse>> updateSMSBased(
      SMSBasedUpdateRequest request) async {
    UpdateVehicleEntryResponse? response;
    try {
      response = await client.updateSMSBased(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<UpdateVehicleEntryResponse>> parkedLocationUpdate(
      ParkedLocationUpdate request) async {
    UpdateVehicleEntryResponse? response;
    try {
      response = await client.parkedLocationUpdate(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<PermissionResponse>> getPermissionData(
      String clientId) async {
    PermissionResponse? response;
    try {
      response = await client.getPermissionData(clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ExitByHNResponse>> getExitByHookNumber(
      String clientId, String hookNumber) async {
    ExitByHNResponse? response;
    try {
      response = await client.getExitByHookNumber(clientId, hookNumber);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<UploadSignatureResponse>> uploadSignature(
    String transactionId,
    String clientId,
    File file,
  ) async {
    UploadSignatureResponse? response;
    try {
      response = await client.uploadSignature(transactionId, clientId, file);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<PostExitByHNResponse>> postExitByHookNumber(
      ExitByHNRequest request) async {
    PostExitByHNResponse? response;
    try {
      response = await client.postExitByHookNumber(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ExitListResponse>> getCheckOutExit(
      String clientId, String searchText) async {
    ExitListResponse? response;
    try {
      response = await client.getCheckOutExit(clientId, searchText);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<ExitVehicleResponse>> exitVehicle(
      ExitVehicleRequest request) async {
    ExitVehicleResponse? response;
    try {
      response = await client.exitVehicle(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<GuestRequestResponse>> getGuestRequest(
      String clientId, String searchText) async {
    GuestRequestResponse? response;
    try {
      response = await client.getGuestRequest(clientId, searchText);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<DriverListResponse>> assignDriver(
      AssignDriverRequest request) async {
    DriverListResponse? response;
    try {
      response = await client.assignDriver(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<LPBaseResponse>> accpetGuestRequest(
      AccpetGuestRequest request) async {
    LPBaseResponse? response;
    try {
      response = await client.accpetGuestRequest(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<LPBaseResponse>> markReady(
      String transactionId, String clientId) async {
    LPBaseResponse? response;
    try {
      response = await client.markReady(transactionId, clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<LPBaseResponse>> markRollback(
      String transactionId, String clientId) async {
    LPBaseResponse? response;
    try {
      response = await client.markRollback(transactionId, clientId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<VehicleNameResponse>> suggestVehicleName(
      String name) async {
    VehicleNameResponse? response;
    try {
      response = await client.suggestVehicleName(name);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<VehicleColorResponse>> suggestVehicleColor(
      String name) async {
    VehicleColorResponse? response;
    try {
      response = await client.suggestVehicleColor(name);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SlotsResponse>> suggestSlots(
      String clientId, String locationId) async {
    SlotsResponse? response;
    try {
      response = await client.suggestSlots(clientId, locationId);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<SummaryResponse>> getSummaryData(
      String clientId, String userId, String search) async {
    SummaryResponse? response;
    try {
      response = await client.getSummaryData(clientId, userId, search);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<RolePermissionResponse>> getRolePermission(
      RolePermissionRequest request) async {
    RolePermissionResponse? response;
    try {
      response = await client.getRolePermission(request);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<LPBaseResponse>> uploadPhotos(
      List<ImageUploadData> photosToUpload) async {
    LPBaseResponse? response;
    if (photosToUpload != null) {
      for (int i = 0; i < photosToUpload.length; i++) {
        ImageUploadData data = photosToUpload[i];
        try {
          File f = File(data.filePath ?? '');
          response = await client.uploadPhotos(
              f, data.transcationId, getLoginData()?.data?.client_id ?? '');
          if (response?.status == 1) {
            await DatabaseHelper.get.deleteById(data.id ?? 0);
          }
        } catch (error, stacktrace) {
          printMessage("Exception occured: $error stackTrace: $stacktrace");
          return BaseResponse()
            ..setException(
                ServerError.withError(error, error: error as DioError));
        }
      }
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<HistoryCountResponse>> getHistoryCount(
      HistoryCountRequest req) async {
    HistoryCountResponse? response;
    try {
      response = await client.getHistoryCount(req);
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }

  Future<BaseResponse<LPBaseResponse>> cardLoss(
      String clientId,
      String userId,
      String transcationId,
      String hookNumber,
      String name,
      String mobile,
      String fineAmount,
      File? rcCard,
      File? aadhar) async {
    LPBaseResponse? response;
    try {
      if (rcCard == null && aadhar == null) {
        response = await client.cardLoss(clientId, userId, transcationId,
            hookNumber, name, mobile, fineAmount);
      } else if (rcCard != null && aadhar == null) {
        response = await client.cardLossWithRC(clientId, userId, transcationId,
            hookNumber, name, mobile, fineAmount, rcCard);
      } else if (rcCard == null && aadhar != null) {
        response = await client.cardLossWithAadhar(clientId, userId,
            transcationId, hookNumber, name, mobile, fineAmount, aadhar);
      } else {
        response = await client.cardLossWithRCAndAadhar(
            clientId,
            userId,
            transcationId,
            hookNumber,
            name,
            mobile,
            fineAmount,
            rcCard,
            aadhar);
      }
    } catch (error, stacktrace) {
      printMessage("Exception occured: $error stackTrace: $stacktrace");
      return BaseResponse()
        ..setException(ServerError.withError(error, error: error as DioError));
    }
    return BaseResponse()..data = response;
  }
}
