import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/HistoryCountResponse.dart';
import 'package:valet_app/Data/Response/HistoryData.dart';
import 'package:valet_app/Data/Response/HistoryResponse.dart';

import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/TodayTab/Presenter/TodayTabPresenter.dart';
import 'package:valet_app/fragment/TodayTab/View/TodayTabView.dart';
import 'package:intl/intl.dart';

import '../../../Data/Request/HistroryCountRequest.dart';

class TodayTabPresenterImpl extends BasePresenter<TodayTabView>
    implements TodayTabPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    getHistoryData();
  }

  getHistoryData() async {
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      final DateTime now = DateTime.now();
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
