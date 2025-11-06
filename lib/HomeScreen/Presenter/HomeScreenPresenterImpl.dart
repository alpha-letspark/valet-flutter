import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/LoginData.dart';
import 'package:valet_app/Data/Response/PermissionResponse.dart';
import 'package:valet_app/HomeScreen/Presenter/HomeScreenPresenter.dart';
import 'package:valet_app/HomeScreen/View/HomeScreenView.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/base/base_presenter.dart';

class HomeScreenPresenterImpl extends BasePresenter<HomeScreenView>
    implements HomeScreenPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    getView()?.handleNotification();

    List<String> roles = apiClientImpl.getViewRoles();
    bool isEntry = roles.contains(Strings.ROLE_ENTRY);
    bool isCheckIn = roles.contains(Strings.ROLE_UNPAKRED) ||
        roles.contains(Strings.ROLE_PARKED);
    bool isCheckOut = roles.contains(Strings.ROLE_CHECKOUT);

    getView()?.setPermissions(isEntry, isCheckIn, isCheckOut);

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      LoginData? data = apiClientImpl.getLoginData()?.data;
      BaseResponse baseResponse =
          await apiClientImpl.getPermissionData(data?.client_id ?? '');
      if (baseResponse.data != null) {
        PermissionResponse? response = baseResponse.data;
        if (response != null) {
          if (response.status == 1) {
            await Preferences.setIntValue(
                Preferences.EXIT_BY_HOOK, response.data?.exit_by_hn ?? 0);
            await Preferences.setIntValue(
                Preferences.EXIT_BY_PIN, response.data?.exit_by_pin ?? 0);
            await Preferences.setIntValue(
                Preferences.ASSIGN_DRIVER, response.data?.assign_req ?? 0);
          }
        }
      }
    }
  }
}
