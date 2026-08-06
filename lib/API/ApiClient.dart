import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:valet_app/Data/Request/AccpetGuestRequest.dart';
import 'package:valet_app/Data/Request/CardBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/CardBasedUpdateRequest.dart';
import 'package:valet_app/Data/Request/CheckHookNumberRequest.dart';
import 'package:valet_app/Data/Request/ExitByHNRequest.dart';
import 'package:valet_app/Data/Request/LoginRequest.dart';
import 'package:valet_app/Data/Request/ParkedLocationUpdate.dart';
import 'package:valet_app/Data/Request/RolePermissionRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedUpdateRequest.dart';
import 'package:valet_app/Data/Request/SaveDeviceTokenRequest.dart';
import 'package:valet_app/Data/Request/SearchGuestRequest.dart';
import 'package:valet_app/Data/Response/CheckHookNumberResponse.dart';
import 'package:valet_app/Data/Response/DriverListResponse.dart';
import 'package:valet_app/Data/Response/EntryMenuNumberResponse.dart';
import 'package:valet_app/Data/Response/ExitByHNResponse.dart';
import 'package:valet_app/Data/Response/ExitListResponse.dart';
import 'package:valet_app/Data/Response/GuestRequestResponse.dart';
import 'package:valet_app/Data/Response/HistoryResponse.dart';
import 'package:valet_app/Data/Response/InputFieldResponse.dart';
import 'package:valet_app/Data/Response/LPBaseResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/ParkingDetailsResponse.dart';
import 'package:valet_app/Data/Response/ParkingLocationResponse.dart';
import 'package:valet_app/Data/Response/PermissionResponse.dart';
import 'package:valet_app/Data/Response/RolePermissionResponse.dart';
import 'package:valet_app/Data/Response/SaveDeviceTokenResponse.dart';
import 'package:valet_app/Data/Response/SearchGuestResponse.dart';
import 'package:valet_app/Data/Response/SignatureResponse.dart';
import 'package:valet_app/Data/Response/SlotsResponse.dart';
import 'package:valet_app/Data/Response/SummaryResponse.dart';
import 'package:valet_app/Data/Response/UnparkedListResponse.dart';
import 'package:valet_app/Data/Response/UpdateVehicleEntryResponse.dart';
import 'package:valet_app/Data/Response/VehicleColorResponse.dart';
import 'package:valet_app/Data/Response/VehicleNameResponse.dart';
import 'package:valet_app/Data/Response/VehicleTypeResponse.dart';

import '../Data/Request/AssignDriverRequest.dart';
import '../Data/Request/ExitVehicleRequest.dart';
import '../Data/Request/HistroryCountRequest.dart';
import '../Data/Request/SettingRequest.dart';
import '../Data/Response/ExitVehicleResponse.dart';
import '../Data/Response/HistoryCountData.dart';
import '../Data/Response/HistoryCountResponse.dart';
import '../Data/Response/NewVehicleEntryResponse.dart';
import '../Data/Response/ParkedInfoResponse.dart';
import '../Data/Response/PostExitByHNResponse.dart';
import '../Data/Response/ScanNumberPlateResponse.dart';
import '../Data/Response/SettingResponse.dart';
import '../Data/Response/UploadSignatureResponse.dart';

part 'ApiClient.g.dart';


//for local testing i chnaged to lacaly..

@RestApi(baseUrl: "https://letsdriev.in/dev/valet/api")

//@RestApi(baseUrl: "http://10.136.86.137:8000/api")

// @RestApi(baseUrl: 'https://dev.letspark.in/api/valet/api')
//@RestApi(baseUrl: 'https://valetapp.letspark.in/apps')
//@RestApi(baseUrl: 'https://letspark.in/dev/valet/apps')

abstract class ApiClient {
  factory ApiClient(Dio dio) {
    return _ApiClient(dio);
  }

  @POST("/login")
  Future<LoginResponse> login(@Body() LoginRequest data);

  @GET("/input_permission")
  Future<InputFieldResponse> getInputPermissionData(
      @Query("client_id") String clientId);

  @GET("/vehicle_type")
  Future<VehicleTypeResponse> getVehicleType(
      @Query("client_id") String clientId);

  @GET("/client_parking")
  Future<ParkingLocationResponse> getParkingLocation(
      @Query("client_id") String clientId);

  @POST("/check_hook")
  Future<CheckHookNumberResponse> checkHookNumber(
      @Body() CheckHookNumberRequest request);

  @GET("/settings")
  Future<SettingResponse> getSettingData(@Query("client_id") String clientId);

  @POST("/settings")
  Future<SettingResponse> updateSetting(@Body() SettingRequest request);

  @POST("/search_guest")
  Future<SearchGuestResponse> searchGuestDetails(
      @Body() SearchGuestRequest request);

  @POST("/anpr")
  @MultiPart()
  Future<ScanNumberPlateResponse> scanNumberPlate(
    @Part(name: "user_id") String userId,
    @Part(name: "client_id") String clientId,
    @Part(name: "photo") File file,
  );

  @GET("/client_driver")
  Future<DriverListResponse> getDriverList(@Query("client_id") String clientId);

  @GET("/history")
  Future<HistoryResponse> getHistoryData(
      @Query("client_id") String clientId, @Query("date") String date);

  @GET("/parked_list")
  Future<ParkedInfoResponse> getParkingListInformation(
      @Query("client_id") String clientId);

  @POST("/card_based_entry")
  Future<NewVehicleEntryResponse> entryCardBased(
      @Body() CardBasedEntryRequest request);

  @POST("/entry")
  Future<NewVehicleEntryResponse> entrySMSBased(
      @Body() SMSBasedEntryRequest request);

  @GET("/signature_tc")
  Future<SignatureResponse> getSignatureTC(@Query("client_id") String clientId);

  @GET("/parked_details")
  Future<ParkingDetailsResponse> getParkingDetails(
      @Query("transaction_id") String transactionId);

  @GET("/menu_number")
  Future<EntryMenuNumberResponse> getMenuNumber(
      @Query("client_id") String clientId, @Query("user_id") String userId);

  @GET("/unparked")
  Future<UnparkedListResponse> getUnParkedVehicleList(
      @Query("client_id") String clientId);

  @POST("/card_based_update")
  Future<UpdateVehicleEntryResponse> updateCardBased(
      @Body() CardBasedUpdateRequest request);

  @POST("/unparked")
  Future<UpdateVehicleEntryResponse> updateSMSBased(
      @Body() SMSBasedUpdateRequest request);

  @POST("/parked_location_update")
  Future<UpdateVehicleEntryResponse> parkedLocationUpdate(
      @Body() ParkedLocationUpdate request);

  @GET("/permissions")
  Future<PermissionResponse> getPermissionData(
      @Query("client_id") String clientId);

  @GET("/search_hook_number")
  Future<ExitByHNResponse> getExitByHookNumber(
      @Query("client_id") String clientId, @Query("hook_number") String userId);

  @POST("/signature_upload")
  @MultiPart()
  Future<UploadSignatureResponse> uploadSignature(
    @Part(name: "transaction_id") String transactionId,
    @Part(name: "client_id") String clientId,
    @Part(name: "photo") File file,
  );

  @POST("/exit_hook_number")
  Future<PostExitByHNResponse> postExitByHookNumber(
      @Body() ExitByHNRequest request);

  @GET("/checkout_exit")
  Future<ExitListResponse> getCheckOutExit(
      @Query("client_id") String clientId, @Query("search") String searchText);

  @POST("/exit")
  Future<ExitVehicleResponse> exitVehicle(@Body() ExitVehicleRequest request);

  @GET("/guest_request")
  Future<GuestRequestResponse> getGuestRequest(
      @Query("client_id") String clientId, @Query("search") String searchText);

  @POST("/assign_driver")
  Future<DriverListResponse> assignDriver(@Body() AssignDriverRequest request);

  @POST("/accept_request")
  Future<LPBaseResponse> accpetGuestRequest(@Body() AccpetGuestRequest request);

  @GET("/ready")
  Future<LPBaseResponse> markReady(
    @Query("transaction_id") String transcationId,
    @Query("client_id") String clientId,
  );

  @GET("/rollback")
  Future<LPBaseResponse> markRollback(
      @Query("transaction_id") String transcationId,
      @Query("client_id") String clientId);

  @GET("/suggest_vehicle_name")
  Future<VehicleNameResponse> suggestVehicleName(@Query("name") String name);

  @GET("/suggest_vehicle_color")
  Future<VehicleColorResponse> suggestVehicleColor(@Query("name") String name);

  @GET("/location_slots")
  Future<SlotsResponse> suggestSlots(@Query("client_id") String clientId,
      @Query("location_id") String locationId);

  @GET("/summary")
  Future<SummaryResponse> getSummaryData(@Query("client_id") String clientId,
      @Query("user_id") String userId, @Query("search") String search);

  @POST("/role_permission")
  Future<RolePermissionResponse> getRolePermission(
      @Body() RolePermissionRequest request);

  @POST("/upload_photos")
  @MultiPart()
  Future<LPBaseResponse> uploadPhotos(
    @Part(name: "files") File file,
    @Part(name: "transaction_id") String transactionId,
    @Part(name: "client_id") String clientId,
  );

  // @GET("/history_counts")
  // Future<HistoryCountResponse> getHistoryCount(
  //     @Body() HistoryCountRequest request);
@GET("/history_counts")
Future<HistoryCountResponse> getHistoryCount(
    @Query("client_id") String clientId);
  @POST("/lostcard_store")
  @MultiPart()
  Future<LPBaseResponse> cardLoss(
      @Part(name: "client_id") String clientId,
      @Part(name: "user_id") String userId,
      @Part(name: "transaction_id") String transcationId,
      @Part(name: "hook_number") String hookNumber,
      @Part(name: "name") String name,
      @Part(name: "mobile") String mobile,
      @Part(name: "fine_amount") String fineAmount);

  @POST("/lostcard_store")
  @MultiPart()
  Future<LPBaseResponse> cardLossWithRC(
      @Part(name: "client_id") String clientId,
      @Part(name: "user_id") String userId,
      @Part(name: "transaction_id") String transcationId,
      @Part(name: "hook_number") String hookNumber,
      @Part(name: "name") String name,
      @Part(name: "mobile") String mobile,
      @Part(name: "fine_amount") String fineAmount,
      @Part(name: "rc_card") File rcCard);

  @POST("/lostcard_store")
  @MultiPart()
  Future<LPBaseResponse> cardLossWithRCAndAadhar(
      @Part(name: "client_id") String clientId,
      @Part(name: "user_id") String userId,
      @Part(name: "transaction_id") String transcationId,
      @Part(name: "hook_number") String hookNumber,
      @Part(name: "name") String name,
      @Part(name: "mobile") String mobile,
      @Part(name: "fine_amount") String fineAmount,
      @Part(name: "rc_card") File rcCard,
      @Part(name: "aadhaar") File aadhar);
  @POST("/lostcard_store")
  @MultiPart()
  Future<LPBaseResponse> cardLossWithAadhar(
      @Part(name: "client_id") String clientId,
      @Part(name: "user_id") String userId,
      @Part(name: "transaction_id") String transcationId,
      @Part(name: "hook_number") String hookNumber,
      @Part(name: "name") String name,
      @Part(name: "mobile") String mobile,
      @Part(name: "fine_amount") String fineAmount,
      @Part(name: "aadhaar") File aadhar);

      @POST("/save-device-token")
    Future<SaveDeviceTokenResponse> saveDeviceToken(
      @Body() SaveDeviceTokenRequest request);
}
