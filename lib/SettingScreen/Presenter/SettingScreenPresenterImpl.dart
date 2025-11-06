import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Request/SettingRequest.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/SettingResponse.dart';
import 'package:valet_app/SettingScreen/Presenter/SettingScreenPresenter.dart';
import 'package:valet_app/SettingScreen/View/SettingScreenView.dart';
import 'package:valet_app/base/base_presenter.dart';

class SettingScreenPresenterImpl extends BasePresenter<SettingScreenView>
    implements SettingScreenPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      BaseResponse baseResponse = await apiClientImpl
          .getSettingData(loginResponse?.data?.client_id ?? "");
      SettingResponse? response = baseResponse.data;
      if (response != null) {
        getView()?.setSettingData(response.data);
      }

      getView()?.hideProgress();
    }
  }

  @override
  void onSubmitClick(bool isGuestReqPermission, bool isEtaPermission,
      bool isSearchSuggest) async {
    // TODO: implement onSubmitClick
    LoginResponse? loginResponse = apiClientImpl.getLoginData();
    SettingRequest request = SettingRequest();
    request.client_id = loginResponse?.data?.client_id ?? "0";
    request.guest_req = isGuestReqPermission ? 1 : 0;
    request.eta_extend = isEtaPermission ? 1 : 0;
    request.search_suggest = isSearchSuggest ? 1 : 0;
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();

      BaseResponse baseResponse = await apiClientImpl.updateSetting(request);
      SettingResponse? response = baseResponse.data;
      if (response != null && response.status == 1) {
        getView()?.showErrorMsg(response.message);
      }

      getView()?.hideProgress();
    }
  }
}
