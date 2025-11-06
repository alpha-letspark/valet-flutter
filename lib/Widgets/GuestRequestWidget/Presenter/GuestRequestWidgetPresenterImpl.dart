import 'package:valet_app/Data/Request/AccpetGuestRequest.dart';
import 'package:valet_app/Data/Request/AssignDriverRequest.dart';
import 'package:valet_app/Data/Response/DriverListData.dart';
import 'package:valet_app/Data/Response/GuestRequestData.dart';
import 'package:valet_app/Data/Response/LPBaseResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Widgets/GuestRequestWidget/Presenter/GuestRequestWidgetPresenter.dart';
import 'package:valet_app/Widgets/GuestRequestWidget/View/GuestRequestWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';

class GuestRequestWidgetPresenterImpl
    extends BasePresenter<GuestRequestWidgetView>
    implements GuestRequestWidgetPresenter {
  @override
  void initData(GuestRequestData data) async {
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
  void onSubmitClick(GuestRequestData data) async {
    // TODO: implement onSubmitClick
    if (data.eta_variable == null) {
      acceptRequest((data.eta_minutes ?? "0").toString(), data);
    } else {
      getView()?.showEtaDialog(data.eta_variable ?? []);
    }
  }

  @override
  void acceptRequest(String eta, GuestRequestData data) async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      AccpetGuestRequest request = AccpetGuestRequest();
      request.eta_minutes = eta;
      request.accept_user_id =
          (apiClientImpl.getLoginData()?.data?.id ?? "0").toString();
      request.transaction_id = data.transaction_id;
      BaseResponse baseResponse =
          await apiClientImpl.accpetGuestRequest(request);
      getView()?.hideProgress();

      if (baseResponse.data != null) {
        LPBaseResponse response = baseResponse.data;

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
  void assignDriver(
      GuestRequestData guestRequestData, DriverListData data) async {
    // TODO: implement assignDriver

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      AssignDriverRequest request = AssignDriverRequest();
      request.transaction_id = guestRequestData.transaction_id;
      request.driver_id = data.id.toString();

      BaseResponse baseResponse = await apiClientImpl.assignDriver(request);
      getView()?.hideProgress();

      if (baseResponse.data != null) {
        DriverListResponse response = baseResponse.data;

        if (response.status == 1) {
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
