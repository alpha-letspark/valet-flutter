import 'package:valet_app/HistoryScreen/Presenter/HistoryScreenPresenter.dart';
import 'package:valet_app/HistoryScreen/View/HistoryScreenView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../Data/BaseResponse.dart';
import '../../Data/Request/HistroryCountRequest.dart';
import '../../Data/Response/HistoryCountResponse.dart';
import '../../Data/Response/LoginResponse.dart';

class HistoryScreenPresenterImpl extends BasePresenter<HistoryScreenView>
    implements HistoryScreenPresenter {
  void initData() async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();

      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      HistoryCountRequest req = HistoryCountRequest();
      req.client_id = loginResponse?.data?.client_id ?? "";
      BaseResponse baseResponse = await apiClientImpl.getHistoryCount(req);
      getView()?.hideProgress();
      HistoryCountResponse? response = baseResponse.data;
      if (response != null) {
        getView()?.setHistoryCount(response.data);
      }
    }
  }
}
