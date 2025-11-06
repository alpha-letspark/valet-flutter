import 'package:intl/intl.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/YesterdayTab/Presenter/YesterdayTabPresenter.dart';
import 'package:valet_app/fragment/YesterdayTab/View/YesterdayTabView.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/HistoryResponse.dart';
import '../../../Data/Response/LoginResponse.dart';

class YesterdayTabPresenterImpl extends BasePresenter<YesterdayTabView>
    implements YesterdayTabPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      final DateTime now = DateTime.now().subtract(const Duration(days: 1));
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      print(formatted);
      BaseResponse baseResponse = await apiClientImpl.getHistoryData(
          loginResponse?.data?.client_id ?? "", formatted);
      getView()?.hideProgress();
      HistoryResponse? response = baseResponse.data;
      if (response != null) {
        getView()?.setHistoryData(response.data ?? []);
      }
    }
  }
}
