import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Request/LoginRequest.dart';
import 'package:valet_app/Data/Request/RolePermissionRequest.dart';
import 'package:valet_app/Data/Request/SaveDeviceTokenRequest.dart';
import 'package:valet_app/Data/Response/InputFieldResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/RolePermissionResponse.dart';
import 'package:valet_app/Data/Response/SaveDeviceTokenResponse.dart';
import 'package:valet_app/LoginScreen/Presenter/LoginScreenPresenter.dart';
import 'package:valet_app/LoginScreen/View/LoginScreenView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../Preferences/preferences.dart';

class LoginScreenPresenterImpl extends BasePresenter<LoginScreenView>
    implements LoginScreenPresenter {
  String playerId = '';
  @override
  void initData() async {
    // TODO: implement initData
    apiClientImpl.initClient();
    getView()?.askPermission();
  }

  @override
  void getPlayerId() {
    OneSignal.User.pushSubscription.addObserver((state) {
      playerId = state.current.id ?? OneSignal.User.pushSubscription.id ?? '';
      if (playerId != null) {
        print("Player Id New $playerId");
      }
    });
  }

  @override
  void onLoginClick(LoginRequest request) async {
    // TODO: implement onLoginClick
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      request.player_id =
          playerId == '' ? OneSignal.User.pushSubscription.id ?? '' : playerId;
          print("Before login");

BaseResponse? baseResponse = await apiClientImpl.login(request);

print("After login");
//print(response);

      //BaseResponse? baseResponse = await apiClientImpl.login(request);

      //BaseResponse? baseResponse = await apiClientImpl.login(request);

print("BaseResponse: $baseResponse");
print("Error Code: ${baseResponse?.errorCode}");
//print("Error Message: ${baseResponse?.e}");
print("Data: ${baseResponse?.data}");

if (baseResponse != null) {
  LoginResponse? response = baseResponse.data;
  print("LoginResponse: $response");
  print("LoginResponse.data: ${response?.data}");

  
}
      if (baseResponse != null) {
        LoginResponse? response = baseResponse.data;
        print('BASERESPOSE DATA------->>>${response?.data}');
        if (response != null) {
          if ((response.status ?? -1) == 0) {
            getView()?.showErrorMsg(response.message);
            getView()?.hideProgress();
            return;
          } else {
            getView()?.hideProgress();
            apiClientImpl.setLoginData(response);
            saveDeviceToken(response);
           
          }
        } else {
          if (baseResponse.errorCode == 401) {
            getView()?.showErrorMsg("Invalid credentials");
          }
          getView()?.hideProgress();
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  void getRolePermissionData(LoginResponse response) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();

      RolePermissionRequest request = RolePermissionRequest();
      request.client_id = (response.data?.client_id ?? 0).toString();
      request.user_id = (response.data?.id ?? 0).toString();

      BaseResponse? baseResponse =
          await apiClientImpl.getRolePermission(request);
      if (baseResponse != null) {
        RolePermissionResponse? rolePermissionResponse = baseResponse.data;
        if (response != null) {
          if ((response.status ?? -1) == 0) {
            getView()?.showErrorMsg(response.message);
            getView()?.hideProgress();
            return;
          } else {
            getView()?.hideProgress();
            List<String> data = [];
            (rolePermissionResponse?.data ?? []).forEach((element) {
              if (element != null) {
                data.add(element);
              }
            });
            apiClientImpl.setViewRoles(data);
            getMandatoryField(response);
          }
        } else {
          if (baseResponse.errorCode == 401) {
            getView()?.showErrorMsg("Invalid credentials");
          }
          getView()?.hideProgress();
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  void getMandatoryField(LoginResponse response) async {
    getView()?.showProgress();
    LoginResponse? loginResponse = apiClientImpl.getLoginData();

    BaseResponse baseResponse = await apiClientImpl
        .getInputPermissionData(loginResponse?.data!.client_id ?? "0");

    InputFieldResponse fieldResponse = baseResponse.data;
    if (fieldResponse != null) {
      getView()?.hideProgress();
      await saveMandatoryData(fieldResponse);
      getView()?.onLoginSuccess(response);
    } else {
      getView()?.hideProgress();
      return null;
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

  void saveDeviceToken(LoginResponse response) async {
  SaveDeviceTokenRequest request = SaveDeviceTokenRequest();

  request.client_id = (response.data?.client_id ?? 0).toString();
  request.user_id = (response.data?.id ?? 0).toString();

  // Always use the latest OneSignal Push Subscription ID
  final pushId = OneSignal.User.pushSubscription.id ?? '';

  request.player_id = pushId;

  print("Saving Player ID: $pushId");
  print("Current Push ID: ${OneSignal.User.pushSubscription.id}");

  BaseResponse? baseResponse = await apiClientImpl.saveDeviceToken(request);

  if (baseResponse != null) {
    SaveDeviceTokenResponse? tokenResponse = baseResponse.data;
    if (tokenResponse != null) {
      getView()?.hideProgress();
    }
  }

  getRolePermissionData(response);
}

//   void saveDeviceToken(LoginResponse response) async {
//     SaveDeviceTokenRequest request = SaveDeviceTokenRequest();
//     request.client_id = (response.data?.client_id ?? 0).toString();
//     request.user_id = (response.data?.id ?? 0).toString();
//     request.player_id = playerId;
//     print("Saving Player ID: $playerId");
// print("Current Push ID: ${OneSignal.User.pushSubscription.id}");

//     BaseResponse? baseResponse = await apiClientImpl.saveDeviceToken(request);
//     if (baseResponse != null) {
//       SaveDeviceTokenResponse? tokenResponse = baseResponse.data;
//       if (tokenResponse != null) {
//         getView()?.hideProgress();
//       }
//     }
//      getRolePermissionData(response);
//   }
}
