import 'package:valet_app/Data/Request/ExitVehicleRequest.dart';
import 'package:valet_app/Data/Request/ParkedLocationUpdate.dart';
import 'package:valet_app/Data/Response/ParkingDetailsData.dart';
import 'package:valet_app/Dialog/TapCarDialog/Presenter/TapCarDialogPresenter.dart';
import 'package:valet_app/Dialog/TapCarDialog/View/TapCarDialogView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/ExitVehicleResponse.dart';
import '../../../Data/Response/LoginData.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Data/Response/ParkingLocationResponse.dart';
import '../../../Data/Response/UpdateVehicleEntryResponse.dart';
import '../../../Preferences/preferences.dart';

class TapCarDialogPresenterImpl extends BasePresenter<TapCarDialogView>
    implements TapCarDialogPresenter {
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
  void onSubmitClick() async {
    // TODO: implement onSubmitClick

    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      ParkedLocationUpdate request = ParkedLocationUpdate();
      request.location = (getView()?.getParkingLocation()?.id ?? "").toString();
      request.transaction_id =
          getView()?.getParkingDetailsData().transaction_id ?? "";
      getView()?.showProgress();
      BaseResponse baseResponse =
          await apiClientImpl.parkedLocationUpdate(request);
      UpdateVehicleEntryResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.onTransactionUpdated();
        }
        getView()?.showErrorMsg(response.message ?? "");
      }
    }
  }

  @override
  void onExitManuallyClicked(ParkingDetailsData data) async {
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

  void exitTranscation(ParkingDetailsData data,
      {String pinNo = '', String password = ''}) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      ExitVehicleRequest request = ExitVehicleRequest();
      request.client_id = loginData?.client_id ?? '';
      request.transaction_id = data.transaction_id;
      request.exit_user_id = (loginData?.id ?? '').toString();

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
}
