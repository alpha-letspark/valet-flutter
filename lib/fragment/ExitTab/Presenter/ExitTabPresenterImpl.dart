import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/ExitListResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/ExitTab/Presenter/ExitTabPresenter.dart';
import 'package:valet_app/fragment/ExitTab/View/ExitTabView.dart';

import '../../../Data/Response/DriverListData.dart';
import '../../../Data/Response/DriverListResponse.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Preferences/preferences.dart';

class ExitTabPresenterImpl extends BasePresenter<ExitTabView>
    implements ExitTabPresenter {
  String? pickupBy;
  int? pickupById;
  @override
  void initData() async {
    // TODO: implement initData
    int? assignDriver =
        await Preferences.getIntValue(Preferences.ASSIGN_DRIVER);
    getView()?.showDriver(assignDriver == 1);
    await checkDriverList();
    getData('');
  }

  @override
  void getData(String searchText) async {
    // TODO: implement getData
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();

      LoginData? loginData = apiClientImpl.getLoginData()?.data;

      BaseResponse baseResponse = await apiClientImpl.getCheckOutExit(
          loginData?.client_id ?? "", searchText);

      getView()?.hideProgress();
      if (baseResponse.data != null) {
        ExitListResponse response = baseResponse.data;

        if (response.status == 1) {
          if (response.data != null) {
            response.data!.forEach(
              (element) {
                element.picked_by = pickupBy;
                element.picked_by_id = pickupById;
              },
            );
          }
          getView()?.setExitDataList(response.data ?? []);
        } else {
          getView()?.setExitDataList([]);
          //getView()?.showErrorMsg(response.message);
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
