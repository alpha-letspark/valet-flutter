import 'dart:math';

import 'package:valet_app/Data/Response/GuestRequestResponse.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/GuestRequestTab/Presenter/GuestRequestTabPresenter.dart';
import 'package:valet_app/fragment/GuestRequestTab/View/GuestRequestTabView.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginData.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Preferences/preferences.dart';

class GuestRequestTabPresenterImpl extends BasePresenter<GuestRequestTabView>
    implements GuestRequestTabPresenter {
  String? pickupBy;
  int? pickupById;

  @override
  void initData(String searchText) async {
    // TODO: implement initData
    await checkDriverList();
    int? assignDriver =
        await Preferences.getIntValue(Preferences.ASSIGN_DRIVER);
    getView()?.showDriver(assignDriver == 1);
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      LoginData? data = apiClientImpl.getLoginData()?.data;
      BaseResponse baseResponse = await apiClientImpl.getGuestRequest(
          data?.client_id ?? '', searchText);
      if (baseResponse.data != null) {
        GuestRequestResponse? response = baseResponse.data;
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

            getView()?.setGuestRequest(response.data ?? []);
          } else {
            getView()?.setGuestRequest(response.data ?? []);
            //getView()?.showErrorMsg(response.message);
          }
        }
      }
    }
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
