import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Data/Response/SummaryResponse.dart';
import 'package:valet_app/SummaryScreen/presenter/SummaryPresenter.dart';
import 'package:valet_app/SummaryScreen/view/SummaryScreenView.dart';
import 'package:valet_app/base/base_presenter.dart';

class SummaryPresenterImpl extends BasePresenter<SummaryScreenView>
    implements SummaryPresenter {
  @override
  void getData(String text, {bool showLoading = true}) async {
    // TODO: implement getData
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      if (showLoading) {
        getView()?.showProgress();
      }

      LoginData? loginData = apiClientImpl.getLoginData()?.data;

      BaseResponse baseResponse = await apiClientImpl.getSummaryData(
          loginData?.client_id ?? "", (loginData?.id ?? "").toString(), text);

      if (showLoading) {
        getView()?.hideProgress();
      }
      if (baseResponse.data != null) {
        SummaryResponse response = baseResponse.data;

        if (response.status == 1) {
          getView()?.setSummaryData(response.data ?? []);
        } else {
          getView()?.setSummaryData([]);
          getView()?.showErrorMsg(response.message);
        }
      }
    }
  }
}
