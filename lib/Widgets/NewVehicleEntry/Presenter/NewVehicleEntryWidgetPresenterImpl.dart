import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:valet_app/Data/ImageUploadData.dart';

import 'package:valet_app/Data/Request/CardBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedEntryRequest.dart';
import 'package:valet_app/Data/Request/SearchGuestRequest.dart';
import 'package:valet_app/Data/Response/CheckHookNumberResponse.dart';
import 'package:valet_app/Data/Response/DriverListData.dart';
import 'package:valet_app/Data/Response/DriverListResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/NewVehicleEntryResponse.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Data/Response/ParkingLocationResponse.dart';
import 'package:valet_app/Data/Response/ScanNumberPlateResponse.dart';
import 'package:valet_app/Data/Response/SearchGuestData.dart';
import 'package:valet_app/Data/Response/SearchGuestResponse.dart';
import 'package:valet_app/Data/Response/SlotsResponse.dart';
import 'package:valet_app/Data/Response/VehicleColorData.dart';
import 'package:valet_app/Data/Response/VehicleColorResponse.dart';
import 'package:valet_app/Data/Response/VehicleNameData.dart';
import 'package:valet_app/Data/Response/VehicleNameResponse.dart';
import 'package:valet_app/Data/Response/VehicleTypeResponse.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/NewVehicleEntry/Presenter/NewVehicleEntryWidgetPresenter.dart';
import 'package:valet_app/Widgets/NewVehicleEntry/View/NewVehicleEntryWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Request/CheckHookNumberRequest.dart';
import '../../../Data/Response/InputFieldResponse.dart';

class NewVehicleEntryWidgetPresenterImpl
    extends BasePresenter<NewVehicleEntryWidgetView>
    implements NewVehicleEntryWidgetPresenter {
  InputFieldResponse? response;
  @override
  void initData() async {
    // TODO: implement initData

    List<String> role = apiClientImpl.getViewRoles();
    bool isParked = role.contains(Strings.ROLE_ISPARKED);
    getView()?.setPermission(isParked);

    LoginResponse? loginResponse = apiClientImpl.getLoginData();
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      response = await getMandatoryField();
      if (response != null) {
        getView()?.onInputFieldResponse(response!);
        await saveMandatoryData(response);

        bool isPresent = (response?.data?.card_based?.card_input_permission
                    ?.contains(Strings.MAND_VEHICLE_TYPE) ??
                false) ||
            (response?.data?.sms_based?.sms_input_permission
                    ?.contains(Strings.MAND_VEHICLE_TYPE) ??
                false);

        if (isPresent) {
          getVehicleType(loginResponse?.data!.client_id ?? "0");
        }
      }

      await checkDriverData();
    }
  }

  Future<InputFieldResponse?> getMandatoryField() async {
    getView()?.showProgress();
    LoginResponse? loginResponse = apiClientImpl.getLoginData();

    BaseResponse baseResponse = await apiClientImpl
        .getInputPermissionData(loginResponse?.data!.client_id ?? "0");

    response = baseResponse.data;
    if (response != null) {
      getView()?.hideProgress();
      //getView()?.onInputFieldResponse(response);
      return response;
    } else {
      getView()?.hideProgress();
      return null;
    }
  }

  void getVehicleType(String s) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl.getVehicleType(s);
      VehicleTypeResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.setVehicleType(response.data ?? []);
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  @override
  void getParkingLocationList() async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl
          .getParkingLocation(loginResponse?.data?.client_id ?? "");
      ParkingLocationResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.setParkingLocationResponse(response.data ?? []);
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  @override
  void checkHookNumber(String number) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (number.length == 1) {
      number = "0" + number;
    }

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      CheckHookNumberRequest request = CheckHookNumberRequest();
      request.client_id = (loginResponse?.data?.client_id ?? "");
      request.hook_number = number;
      BaseResponse baseResponse = await apiClientImpl.checkHookNumber(request);
      CheckHookNumberResponse? response = baseResponse.data;
      if (response != null) {
        getView()?.setHookNumberResponse(response);
      } else {
        CheckHookNumberResponse response = CheckHookNumberResponse();

        getView()?.setHookNumberResponse(response);
      }
    }
  }

  @override
  Future<List<SearchGuestData>> searchGuestDetails(String search) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      SearchGuestRequest request = SearchGuestRequest();
      request.vehicle_number = search;
      request.client_id = loginResponse?.data?.client_id ?? "";

      BaseResponse response = await apiClientImpl.searchGuestDetails(request);
      if (response != null && response.data != null) {
        SearchGuestResponse searchGuestResponse = response.data;
        if (searchGuestResponse != null && searchGuestResponse.data != null) {
          return Future.value(searchGuestResponse.data);
        } else {
          return [];
        }
      }
      return [];
    }

    return [];
  }

  @override
  void scanNumberPlate(XFile photo) async {
    // TODO: implement scanNumberPlate

    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      File file = File(photo.path);

      BaseResponse baseResponse = await apiClientImpl.scanNumberPlate(
          (loginResponse?.data?.id ?? "").toString(),
          (loginResponse?.data?.client_id ?? "").toString(),
          file);
      ScanNumberPlateResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 0) {
          getView()?.showErrorMsg(response.message ?? "");
          return;
        }
        getView()?.onNumberPlateScan(response);
      }
    }
  }

  @override
  void getDriverList() async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl
          .getDriverList(loginResponse?.data?.client_id ?? "");
      DriverListResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.setDriverListResponse(response.data ?? []);
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  Future<void> checkDriverData() async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl
          .getDriverList(loginResponse?.data?.client_id ?? "");
      DriverListResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          List<DriverListData> data = response.data ?? [];
          LoginResponse? loginResponse = apiClientImpl.getLoginData();
          int userId = loginResponse?.data?.id ?? 0;

          DriverListData? driverListData = data.firstWhere(
              (element) => element.id == userId,
              orElse: () => DriverListData());
          if (driverListData.id != null) {
            getView()?.handleDriverListClick(driverListData);
          }
        }
      }
    }
  }

  @override
  void callCardBasedAPI() async {
    // TODO: implement callCardBasedAPI
    LoginResponse? loginResponse = apiClientImpl.getLoginData();
    CardBasedEntryRequest request = CardBasedEntryRequest();
    request.client_id = loginResponse?.data?.client_id ?? "";
    request.entry_user_id = (loginResponse?.data?.id ?? '').toString();
    request.vehicle_number = getView()?.getVehicleNumber();
    request.vehicle_type = (getView()?.getVehicleType()).toString();
    request.valuable = getView()?.isValuableSelected();
    request.valuable_things = getView()?.isValueableText();
    request.driver = getView()?.getDriverData() == null
        ? "0"
        : (getView()?.getDriverData()!.id).toString();
    request.location = getView()?.getParkingLocationData() == null
        ? "0"
        : (getView()?.getParkingLocationData()!.id).toString();
    request.hook_number = getView()?.getHookNumber();
    request.notes = getView()?.getNotes();
    request.is_parked = (getView()?.isVehicleParked() ?? false) ? "1" : "0";

    if (request.hook_number != null) {
      if (request.hook_number!.length == 1) {
        request.hook_number = "0" + request.hook_number!;
      }
    }
    request.vehicle_color = getView()?.getVehicleColor();
    request.vehicle_name = getView()?.getVehicleName();
    request.slots = getView()?.getSlots();

    List<String> cardbasedMandatory =
        await Preferences.getListOfString(Preferences.CARD_ENTRY_MANDATORY);

    bool isError = checkMandatoryfields(cardbasedMandatory, request);
    if (isError) {
      getView()?.showErrorMsg("Please enter all the mandatory fields");
      return;
    }

    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      getView()?.showProgress();

      BaseResponse baseResponse = await apiClientImpl.entryCardBased(request);
      NewVehicleEntryResponse? response = baseResponse.data;

      getView()?.hideProgress();
      if (response != null && response.status == 1) {
        await saveImagesInDB(response);
        if (getView()?.getSignatureFile() != null) {
          uploadSignature(response);
          return;
        }
        getView()?.showErrorMsg(response.message);
        getView()?.onTransactionCompleted();
        getView()?.clearData();
        uploadImages(response);
      } else {
        if (response != null && response.message != 'error') {
          getView()?.showErrorMsg(response.message);
        }
      }
    }
  }

  @override
  void callSmsBasedAPI() async {
    // TODO: implement callSmsBasedAPI
    LoginResponse? loginResponse = apiClientImpl.getLoginData();
    SMSBasedEntryRequest request = SMSBasedEntryRequest();
    request.client_id = loginResponse?.data?.client_id ?? "";
    request.entry_user_id = (loginResponse?.data?.id ?? '').toString();
    request.vehicle_number = getView()?.getVehicleNumber();
    request.vehicle_type = (getView()?.getVehicleType()).toString();
    request.valuable = getView()?.isValuableSelected();
    request.valuable_things = getView()?.isValueableText();
    request.driver = getView()?.getDriverData() == null
        ? "0"
        : (getView()?.getDriverData()!.id).toString();
    request.location = getView()?.getParkingLocationData() == null
        ? "0"
        : (getView()?.getParkingLocationData()!.id).toString();
    request.hook_number = getView()?.getHookNumber();
    request.notes = getView()?.getNotes();
    request.is_parked = (getView()?.isVehicleParked() ?? false) ? "1" : "0";
    request.guest_email = getView()?.getGuestEmail();
    request.guest_mobile = getView()?.getGuestMobileNumber();
    request.guest_name = getView()?.getGuestName();

    if (request.hook_number != null) {
      if (request.hook_number!.length == 1) {
        request.hook_number = "0" + request.hook_number!;
      }
    }
    request.vehicle_color = getView()?.getVehicleColor();
    request.vehicle_name = getView()?.getVehicleName();
    request.slots = getView()?.getSlots();
    bool isOnline = await getView()?.isOnline() ?? false;

    List<String> smsEntryMandatory =
        await Preferences.getListOfString(Preferences.SMS_ENTRY_MANDATORY);

    bool isError = checkMandatoryfields(smsEntryMandatory, request);
    if (isError) {
      getView()?.showErrorMsg("Please enter all the mandatory fields");
      return;
    }

    if (isOnline) {
      getView()?.showProgress();

      BaseResponse baseResponse = await apiClientImpl.entrySMSBased(request);
      NewVehicleEntryResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null && response.status == 1) {
        await saveImagesInDB(response);
        if (getView()?.getSignatureFile() != null) {
          uploadSignature(response);
          return;
        }
        getView()?.showErrorMsg(response.message);
        getView()?.onTransactionCompleted();
        getView()?.clearData();
        uploadImages(response);
      } else {
        getView()?.showErrorMsg(response?.message ?? '');
      }
    }
  }

  Future<void> saveMandatoryData(InputFieldResponse? response) async {
    if (response != null) {
      List<String> data = [];
      (response.data?.card_based?.card_input_permission ?? [])
          .forEach((element) {
        if (element != null) {
          data.add(element);
        }
      });

      await Preferences.setListOfString(Preferences.CARD_PERMISSION, data);

      List<String> cardEntry = [];
      (response.data?.card_based?.card_entry_mondatory ?? [])
          .forEach((element) {
        if (element != null) {
          cardEntry.add(element);
        }
      });

      await Preferences.setListOfString(
          Preferences.CARD_ENTRY_MANDATORY, cardEntry);

      List<String> cardUpdate = [];
      (response.data?.card_based?.card_update_mondatory ?? [])
          .forEach((element) {
        if (element != null) {
          cardUpdate.add(element);
        }
      });

      await Preferences.setListOfString(
          Preferences.CARD_UPDATE_MANDATORY, cardUpdate);

      List<String> smsPermission = [];
      (response.data?.sms_based?.sms_input_permission ?? []).forEach((element) {
        if (element != null) {
          smsPermission.add(element);
        }
      });

      await Preferences.setListOfString(
          Preferences.SMS_PERMISSIONS, smsPermission);

      List<String> smsEntry = [];
      (response.data?.sms_based?.sms_entry_mondatory ?? []).forEach((element) {
        if (element != null) {
          smsEntry.add(element);
        }
      });

      await Preferences.setListOfString(
          Preferences.SMS_ENTRY_MANDATORY, smsEntry);

      List<String> smsUpdate = [];
      (response.data?.sms_based?.sms_update_mondatory ?? []).forEach((element) {
        if (element != null) {
          smsUpdate.add(element);
        }
      });

      await Preferences.setListOfString(
          Preferences.SMS_UPDATE_MANDATORY, smsUpdate);
    }
    return;
  }

  void uploadSignature(NewVehicleEntryResponse response) async {
    File? file = getView()?.getSignatureFile();
    if (file != null) {
      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl.uploadSignature(
          (response.data?.transaction_id ?? "").toString(),
          response.data?.client_id ?? "",
          file);
      getView()?.hideProgress();
    }

    getView()?.showErrorMsg(response.message);
    getView()?.onTransactionCompleted();
    getView()?.clearData();
    uploadImages(response);
  }

  @override
  Future<List<VehicleNameData>> suggestVehicleName(String search) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      BaseResponse response = await apiClientImpl.suggestVehicleName(search);
      if (response != null && response.data != null) {
        VehicleNameResponse searchGuestResponse = response.data;
        if (searchGuestResponse != null && searchGuestResponse.data != null) {
          return Future.value(searchGuestResponse.data);
        } else {
          return [];
        }
      }
      return [];
    }

    return [];
  }

  @override
  Future<List<VehicleColorData>> suggestVehicleColor(String search) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      BaseResponse response = await apiClientImpl.suggestVehicleColor(search);
      if (response != null && response.data != null) {
        VehicleColorResponse searchGuestResponse = response.data;
        if (searchGuestResponse != null && searchGuestResponse.data != null) {
          return Future.value(searchGuestResponse.data);
        } else {
          return [];
        }
      }
      return [];
    }

    return [];
  }

  @override
  void onParkingLocationSelected(
      ParkingLocationData? parkingLocationData) async {
    // TODO: implement onParkingLocationSelected

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      BaseResponse baseResponse = await apiClientImpl.suggestSlots(
          (apiClientImpl.getLoginData()?.data?.client_id ?? 0).toString(),
          (parkingLocationData?.id ?? 0).toString());

      if (baseResponse.data != null) {
        SlotsResponse? response = baseResponse.data;
        getView()?.setSlotsList(response?.data ?? []);
      } else {
        getView()?.setSlotsList([]);
      }
    }
  }

  bool checkMandatoryfields(List<String> mandatory, var request) {
    bool vehicleNumberError = false;
    bool mobileeNumberError = false;
    bool emailError = false;
    bool nameError = false;
    bool valuableError = false;
    bool valetDriverrError = false;
    bool parkingLocationError = false;
    bool hookNumberError = false;
    bool notesError = false;
    bool vehicleTypeError = false;
    bool slotsError = false;
    bool vehicleNameError = false;
    bool vehicleColorError = false;
    bool signatureError = false;
    bool isParkedError = false;
    bool photoError = false;

    bool isError = false;
    if (mandatory.isNotEmpty) {
      if (mandatory.contains(Strings.MAND_VEHICLE_NUMBER)) {
        if (request.vehicle_number == "") {
          vehicleNumberError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_VEHICLE_TYPE)) {
        if (request.vehicle_type == "" || request.vehicle_type == "-1") {
          vehicleTypeError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_GUEST_MOBILE)) {
        if (request.guest_mobile == "") {
          mobileeNumberError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_GUEST_NAME)) {
        if (request.guest_name == "") {
          nameError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_VALUABLE)) {
        if (request.valuable == "") {
          valuableError = true;
          isError = true;
        }
      }

      if (mandatory.contains(Strings.MAND_VALET_DRIVER)) {
        if (request.driver == "" || request.driver == "0") {
          valetDriverrError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_PARKING_LOT)) {
        if (request.location == "" || request.location == "0") {
          parkingLocationError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_HOOK_NUMBER)) {
        if (request.hook_number == "") {
          hookNumberError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_NOTE)) {
        if (request.notes == "") {
          notesError = true;
          isError = true;
        }
      }

      if (mandatory.contains(Strings.MAND_VEHICLE_NAME)) {
        if (request.vehicle_name == "") {
          vehicleNameError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_VEHICLE_COLOR)) {
        if (request.vehicle_color == "") {
          vehicleColorError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_SLOTS)) {
        if (request.slots == "") {
          slotsError = true;
          isError = true;
        }
      }

      if (mandatory.contains(Strings.MAND_GUEST_EMAIL)) {
        if (request.guest_email == "") {
          emailError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_SIGNATURE)) {
        if (getView()?.getSignatureFile() == null) {
          signatureError = true;
          isError = true;
        }
      }

      if (mandatory.contains(Strings.MAND_PHOTOS)) {
        if (getView()?.getUploadedPhoto() == null ||
            (getView()?.getUploadedPhoto() ?? []).isEmpty) {
          photoError = true;
          isError = true;
        }
      }

      if (mandatory.contains(Strings.MAND_IS_PARKED)) {
        if (request.is_parked == "" || request.is_parked == "0") {
          isParkedError = true;
          isError = true;
        }
      }
    }
    getView()?.setErrorFields(
        vehicleNumberError,
        mobileeNumberError,
        emailError,
        nameError,
        valuableError,
        valetDriverrError,
        parkingLocationError,
        hookNumberError,
        notesError,
        vehicleTypeError,
        slotsError,
        vehicleNameError,
        vehicleColorError,
        signatureError,
        photoError,
        isParkedError);
    return isError;
  }

  Future<void> saveImagesInDB(NewVehicleEntryResponse response) async {
    List<File?> imagesToUpload = getView()?.getUploadedPhoto() ?? [];
    List<ImageUploadData> data = [];
    imagesToUpload.forEach((element) {
      ImageUploadData img = ImageUploadData();
      img.filePath = element?.path ?? '';
      img.transcationId = (response.data?.transaction_id ?? 0).toString();
      img.isUploaded = false;
      data.add(img);
    });

    await db.insertImageData(data);
    List<ImageUploadData>? newImages = await db.getImageFileByTranscationId(
        (response.data?.transaction_id ?? 0).toString());

    return;
  }

  void uploadImages(NewVehicleEntryResponse response) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      List<ImageUploadData>? photosToUpload =
          await db.getImageFileByTranscationId(
              (response.data?.transaction_id ?? 0).toString());
      await apiClientImpl.uploadPhotos(photosToUpload ?? []);
    }
  }
}
