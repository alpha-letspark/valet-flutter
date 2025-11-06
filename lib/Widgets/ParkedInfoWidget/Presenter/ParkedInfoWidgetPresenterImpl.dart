import 'package:valet_app/Data/Response/ParkedInfoResponse.dart';
import 'package:valet_app/Widgets/ParkedInfoWidget/Presenter/ParkedInfoWidgetPresenter.dart';
import 'package:valet_app/Widgets/ParkedInfoWidget/View/ParkedInfoWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/LoginResponse.dart';
import '../../../Data/Response/ParkingDetailsResponse.dart';
import '../../../Data/Response/ParkingLocationData.dart';
import '../../../Data/Response/ParkingLocationResponse.dart';

class ParkedInfoWidgetPresenterImpl extends BasePresenter<ParkedInfoWidgetView>
    implements ParkedInfoWidgetPresenter {
  @override
  void initData() async {
    // TODO: implement initData
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      String clientId = loginResponse?.data?.client_id ?? "";

      BaseResponse baseResponse =
          await apiClientImpl.getParkingLocation(clientId);
      ParkingLocationResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          //getView()?.setParkingLocationResponse(response.data ?? []);
          callGetParkingListInformation(clientId, response.data ?? []);
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  void callGetParkingListInformation(
      String clientId, List<ParkingLocationData> data) async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      getView()?.showProgress();

      BaseResponse baseResponse =
          await apiClientImpl.getParkingListInformation(clientId);
      ParkedInfoResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.setParkingLocationResponse(
            data,
            response.data ?? [],
          );
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }

  @override
  void onCarTap(String transcationId) async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      getView()?.showProgress();

      BaseResponse baseResponse =
          await apiClientImpl.getParkingDetails(transcationId);
      ParkingDetailsResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.data != null && response.status == 1) {
          getView()?.onCarDetails(
              response.data!.isNotEmpty ? response.data![0] : null);
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }
}
