import 'package:valet_app/Data/Request/ExitVehicleRequest.dart';
import 'package:valet_app/Data/Response/ExitListData.dart';
import 'package:valet_app/Data/Response/ExitVehicleResponse.dart';
import 'package:valet_app/Data/Response/LPBaseResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Widgets/ExitListWidget/Presenter/ExitListWidgetPresenter.dart';
import 'package:valet_app/Widgets/ExitListWidget/View/ExitListWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Request/ExitByHNRequest.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Data/Response/PostExitByHNResponse.dart';

class ExitListWidgetPresenterImpl extends BasePresenter<ExitListWidgetView>
    implements ExitListWidgetPresenter {
  @override
  void initData(ExitListData data) async {
    List<String> visible = [];
    List<String> mandatory = [];

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
  void markReady(ExitListData data) async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl.markReady(
          data.transaction_id ?? '', loginResponse?.data?.client_id ?? "");
      LPBaseResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.onTranscationSuccess();
          getView()?.showErrorMsg(response.message ?? "");
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  @override
  void markRollback(ExitListData data) async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl.markRollback(
          data.transaction_id ?? '', loginResponse?.data?.client_id ?? "");
      LPBaseResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.onTranscationSuccess();
          getView()?.showErrorMsg(response.message ?? "");
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  @override
  void onSubmitClick(ExitListData data) async {
    // TODO: implement onSubmitClick

    //exitTranscation(data);
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      ExitByHNRequest request = ExitByHNRequest();
      request.client_id = loginData?.client_id ?? "";
      request.exit_user_id = getView()?.getDriverData() == null
          ? (loginData?.id ?? "").toString()
          : (getView()?.getDriverData()?.id ?? "").toString();
      request.transaction_id = data.transaction_id;

      BaseResponse baseResponse =
          await apiClientImpl.postExitByHookNumber(request);
      getView()?.hideProgress();
      if (baseResponse.data != null) {
        PostExitByHNResponse response = baseResponse.data;
        if (response.status == 1) {
          getView()?.onTranscationSuccess();
          getView()?.showErrorMsg(response.message);
        } else {
          getView()?.showErrorMsg(response.message);
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  @override
  void exitTranscation(ExitListData data,
      {String pinNo = '', String password = ''}) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      ExitVehicleRequest request = ExitVehicleRequest();
      request.client_id = loginData?.client_id ?? '';
      request.transaction_id = data.transaction_id;
      request.exit_user_id = getView()?.getDriverData() == null
          ? (loginData?.id ?? '').toString()
          : (getView()?.getDriverData()?.id ?? '').toString();
      request.pin = pinNo;
      request.password = password;

      BaseResponse baseResponse = await apiClientImpl.exitVehicle(request);
      getView()?.hideProgress();

      if (baseResponse.data != null) {
        ExitVehicleResponse response = baseResponse.data;

        if (response.status == 1) {
          getView()?.onTranscationSuccess();
          getView()?.showErrorMsg(response.message);
        } else {
          getView()?.showErrorMsg(response.message);
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  @override
  void onExitManuallyClicked(ExitListData data) async {
    // TODO: implement onExitManuallyClick
    int isExitByPin = await Preferences.getIntValue(Preferences.EXIT_BY_PIN);
    String isMasterKey = apiClientImpl.getLoginData()?.data?.masterkey ?? "0";

    if (isExitByPin == 1 || isMasterKey == "1") {
      String isMasterKey = apiClientImpl.getLoginData()?.data?.masterkey ?? "0";
      getView()?.showPinDialog(data, isMasterKey, isExitByPin == 1);
    } else {
      //exitTranscation(data);
      getView()?.showErrorMsg("You do not have the permission");
    }
  }
}
