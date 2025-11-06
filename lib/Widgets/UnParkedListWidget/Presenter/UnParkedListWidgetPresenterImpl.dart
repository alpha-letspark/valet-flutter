import 'package:valet_app/Data/Request/CardBasedUpdateRequest.dart';
import 'package:valet_app/Data/Request/SMSBasedUpdateRequest.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Data/Response/UpdateVehicleEntryResponse.dart';
import 'package:valet_app/Data/Response/VehicleColorData.dart';
import 'package:valet_app/Data/Response/VehicleColorResponse.dart';
import 'package:valet_app/Data/Response/VehicleNameData.dart';
import 'package:valet_app/Data/Response/VehicleNameResponse.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Widgets/UnParkedListWidget/Presenter/UnParkedListWidgetPresenter.dart';
import 'package:valet_app/Widgets/UnParkedListWidget/View/UnParkedListWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/ParkingLocationResponse.dart';
import '../../../Data/Response/SlotsResponse.dart';
import '../../../Data/Response/UnparkedListData.dart';
import '../../../Data/Response/VehicleTypeResponse.dart';
import '../../../Util/Strings.dart';

class UnParkedListWidgetPresenterImpl
    extends BasePresenter<UnParkedListWidgetView>
    implements UnParkedListWidgetPresenter {
  List<String> visible = [];
  List<String> mandatory = [];

  @override
  void initData(UnparkedListData data) async {
    if (data.is_card_based ?? false) {
      visible = await Preferences.getListOfString(Preferences.CARD_PERMISSION);
      mandatory =
          await Preferences.getListOfString(Preferences.CARD_UPDATE_MANDATORY);
    } else {
      visible = await Preferences.getListOfString(Preferences.SMS_PERMISSIONS);
      mandatory =
          await Preferences.getListOfString(Preferences.SMS_UPDATE_MANDATORY);
    }

    getView()?.setVisibleFieldList(visible);
    getView()?.setMandatoryFieldList(mandatory);
  }

  @override
  void getVehicleType() async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? data = apiClientImpl.getLoginData()?.data;
      BaseResponse baseResponse =
          await apiClientImpl.getVehicleType(data?.client_id ?? "0");
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

  @override
  void onSubmitClick(UnparkedListData data) {
    // TODO: implement onSubmitClick
    if (data.is_card_based ?? false) {
      updateCardBased(data);
    } else {
      updateSMSBased(data);
    }
  }

  void updateCardBased(UnparkedListData data) async {
    CardBasedUpdateRequest request = CardBasedUpdateRequest();
    LoginData? loginData = apiClientImpl.getLoginData()?.data;
    request.client_id = loginData?.client_id ?? "";
    request.transaction_id = data.transaction_id ?? "";
    request.entry_user_id = (loginData?.id ?? "").toString();
    request.vehicle_number = getView()?.getVehicleNumber();
    request.vehicle_type = getView()?.getVehicleType().toString();

    request.valuable = getView()?.isValuableSelected();
    request.valuable_things = getView()?.isValueableText();
    request.image_names = getView()?.getUploadedPhoto();
    request.driver = getView()?.getDriverData() == null
        ? "0"
        : (getView()?.getDriverData()!.id).toString();
    request.location = getView()?.getParkingLocationData() == null
        ? "0"
        : (getView()?.getParkingLocationData()!.id).toString();
    request.hook_number = getView()?.getHookNumber();
    request.notes = getView()?.getNotes();
    request.is_parked = "1";
    request.slots = getView()?.getSlots();
    request.vehicle_color = getView()?.getVehicleColor();
    request.vehicle_name = getView()?.getVehicleName();

    bool isError = checkMandatoryData(request);
    if (isError) {
      getView()?.showErrorMsg("Please enter all the mandatoryFields");
      return;
    }

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      BaseResponse? baseResponse = await apiClientImpl.updateCardBased(request);
      getView()?.hideProgress();

      if (baseResponse != null) {
        UpdateVehicleEntryResponse? response = baseResponse.data;
        if (response != null) {
          if (response.status == 1) {
            getView()?.onTranscationSuccess();
          }
          getView()?.showErrorMsg(response.message);
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  void updateSMSBased(UnparkedListData data) async {
    SMSBasedUpdateRequest request = SMSBasedUpdateRequest();
    LoginData? loginData = apiClientImpl.getLoginData()?.data;
    request.client_id = loginData?.client_id ?? "";
    request.transaction_id = data.transaction_id ?? "";
    request.entry_user_id = (loginData?.id ?? "").toString();

    request.vehicle_number = getView()?.getVehicleNumber();
    request.vehicle_type = (getView()?.getVehicleType()).toString();
    request.valuable = getView()?.isValuableSelected();
    request.valuable_things = getView()?.isValueableText();
    request.image_names = getView()?.getUploadedPhoto();
    request.driver = getView()?.getDriverData() == null
        ? "0"
        : (getView()?.getDriverData()!.id).toString();
    request.location = getView()?.getParkingLocationData() == null
        ? "0"
        : (getView()?.getParkingLocationData()!.id).toString();
    request.hook_number = getView()?.getHookNumber();
    request.notes = getView()?.getNotes();
    request.is_parked = "1";
    request.guest_email = getView()?.getGuestEmail();
    request.guest_mobile = getView()?.getGuestMobileNumber();
    request.guest_name = getView()?.getGuestName();
    request.slots = getView()?.getSlots();
    request.vehicle_color = getView()?.getVehicleColor();
    request.vehicle_name = getView()?.getVehicleName();

    bool isError = checkMandatoryData(request);
    if (isError) {
      getView()?.showErrorMsg("Please enter all the mandatory fields");
      return;
    }

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      BaseResponse? baseResponse = await apiClientImpl.updateSMSBased(request);
      getView()?.hideProgress();

      if (baseResponse != null) {
        UpdateVehicleEntryResponse? response = baseResponse.data;
        if (response != null) {
          if (response.status == 1) {
            getView()?.onTranscationSuccess();
          }
          getView()?.showErrorMsg(response.message);
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
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

  bool checkMandatoryData(var request) {
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

    bool isError = false;
    if (mandatory.isNotEmpty) {
      if (mandatory.contains(Strings.MAND_VEHICLE_NUMBER)) {
        if (request.vehicle_number == "") {
          vehicleNumberError = true;
          isError = true;
        }
      }
      if (mandatory.contains(Strings.MAND_VEHICLE_TYPE)) {
        if (request.vehicle_type == "") {
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
      // if (mandatory.contains(Strings.MAND_GUEST_EMAIL)) {
      //   if (request.guest_email == "") {
      //     emailError = true;
      //     isError = true;
      //   }
      // }

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
    );
    return isError;
  }
}
