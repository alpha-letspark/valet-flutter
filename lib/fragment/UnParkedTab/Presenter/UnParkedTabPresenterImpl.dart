import 'package:valet_app/Data/Response/UnparkedListResponse.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/UnParkedTab/Presenter/UnParkedTabPresenter.dart';
import 'package:valet_app/fragment/UnParkedTab/View/UnParkedTabView.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/LoginResponse.dart';

class UnParkedTabPresenterImpl extends BasePresenter<UnParkedTabview>
    implements UnParkedTabPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      getView()?.showProgress();
      BaseResponse baseResponse = await apiClientImpl
          .getUnParkedVehicleList(loginResponse?.data?.client_id ?? "");
      UnparkedListResponse? response = baseResponse.data;
      getView()?.hideProgress();
      if (response != null) {
        if (response.status == 1) {
          getView()?.setUnparekedListItem(response.data ?? []);
        } else {
          getView()?.setUnparekedListItem([]);
          //getView()?.showErrorMsg(response.message ?? "");
        }
      }
    }
  }
}
