import 'package:valet_app/Data/Request/ExitByHNRequest.dart';
import 'package:valet_app/Data/Request/ParkedLocationUpdate.dart';
import 'package:valet_app/Data/Response/ExitByHNData.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Data/Response/ParkingLocationData.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Widgets/ExitByHNWidget/presenter/ExitByHNWidgetPresenter.dart';
import 'package:valet_app/Widgets/ExitByHNWidget/view/ExitByHNWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Data/Response/ParkingLocationResponse.dart';
import '../../../Data/Response/PostExitByHNResponse.dart';
import '../../../Data/Response/UpdateVehicleEntryResponse.dart';

class ExitByHNWidgetPresenterImpl extends BasePresenter<ExitByHNWidgetView>
    implements ExitByHNWidgetPresenter {
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
  void onExitClick(ExitByHNData data) async {
    // TODO: implement onExitClick

    // int isExitByPin = await Preferences.getIntValue(Preferences.EXIT_BY_PIN);
    // if (isExitByPin == 1) {
    //   String isMasterKey = apiClientImpl.getLoginData()?.data?.masterkey ?? "0";
    //   getView()?.showPinDialog(data, isMasterKey);
    // } else {
    //   exitTranscation(data);
    // }

    exitTranscation(data);
  }

  @override
  void exitTranscation(ExitByHNData data,
      {String pinNo = '', String password = ''}) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      ExitByHNRequest request = ExitByHNRequest();
      request.client_id = loginData?.client_id ?? "";
      request.exit_user_id = getView()?.getDriverListData() == null
          ? (loginData?.id ?? "").toString()
          : (getView()?.getDriverListData()?.id ?? "").toString();
      request.transaction_id = data.transaction_id;

      BaseResponse baseResponse =
          await apiClientImpl.postExitByHookNumber(request);
      getView()?.hideProgress();
      if (baseResponse.data != null) {
        PostExitByHNResponse response = baseResponse.data;
        if (response.status == 1) {
          getView()?.onDataUpdated();
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
  void updateParkingLocation(
      ParkingLocationData data, String transactionId) async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      ParkedLocationUpdate request = ParkedLocationUpdate();
      request.location = (data.id ?? "").toString();
      request.transaction_id = transactionId;
      getView()?.showProgress();
      BaseResponse baseResponse =
          await apiClientImpl.parkedLocationUpdate(request);
      UpdateVehicleEntryResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {}
        getView()?.showErrorMsg(response.message ?? "");
      }
    }
  }
}
