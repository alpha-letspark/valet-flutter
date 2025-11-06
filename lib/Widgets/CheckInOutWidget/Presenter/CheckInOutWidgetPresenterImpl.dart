import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/CheckInOutWidget/Presenter/CheckInOutWidgetPresenter.dart';
import 'package:valet_app/Widgets/CheckInOutWidget/View/CheckInOutWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/BaseResponse.dart';
import '../../../Data/Response/EntryMenuNumberResponse.dart';
import '../../../Data/Response/LoginData.dart';

class CheckInOutWidgetPresenterImpl extends BasePresenter<CheckInOutWidgetView>
    implements CheckInOutWidgetPresenter {
  @override
  void initData() async {
    List<String> roles = apiClientImpl.getViewRoles();
    bool isCheckIn = roles.contains(Strings.ROLE_UNPAKRED) ||
        roles.contains(Strings.ROLE_PARKED);
    bool isCheckOut = roles.contains(Strings.ROLE_CHECKOUT);

    getView()?.setPermissions(isCheckIn, isCheckOut);

    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      LoginData? loginData = apiClientImpl.getLoginData()?.data;
      if (loginData != null) {
        BaseResponse baseResponse = await apiClientImpl.getMenuNumber(
            loginData.client_id ?? "0", loginData.id.toString());
        if (baseResponse != null) {
          EntryMenuNumberResponse? response = baseResponse.data;
          if (response != null) {
            getView()?.setMenuNumberResponse(response);
          }
        }
      }
    }
  }
}
