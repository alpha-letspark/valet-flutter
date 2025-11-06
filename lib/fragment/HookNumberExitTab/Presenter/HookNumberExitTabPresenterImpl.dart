import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/ExitByHNResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/HookNumberExitTab/Presenter/HookNumberExitTabPresenter.dart';
import 'package:valet_app/fragment/HookNumberExitTab/View/HookNumberExitTabView.dart';

import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';

class HookNumberExitTabPresenterImpl
    extends BasePresenter<HookNumberExitTabView>
    implements HookNumberExitTabPresenter {
  String? pickupBy;
  int? pickupById;
  @override
  void onSearchTextChanged(String searchText) async {
    // TODO: implement onSearchTextChanged

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      //getView()?.showProgress();
      LoginData? loginData = apiClientImpl.getLoginData()?.data;

      BaseResponse baseResponse = await apiClientImpl.getExitByHookNumber(
          loginData?.client_id ?? "", searchText);
      //getView()?.hideProgress();
      if (baseResponse.data != null) {
        ExitByHNResponse? response = baseResponse.data;
        if (response != null) {
          if (response.status == 1) {
            if (response.data != null) {
              response.data!.forEach(
                (element) {
                  element.picked_by = pickupBy;
                  element.picked_by_id = pickupById;
                },
              );
            }

            getView()?.setResponse(response.data ?? []);
          } else {
            getView()?.setResponse([]);
          }
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }

  @override
  void initData() async {
    // TODO: implement initData
    int? assignDriver =
        await Preferences.getIntValue(Preferences.ASSIGN_DRIVER);
    getView()?.showDriver(assignDriver == 1);
    await checkDriverList();
  }

  Future<void> checkDriverList() async {
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
            pickupBy = driverListData.name;
            pickupById = driverListData.id;
          }
        }
      }
    }
  }
}
