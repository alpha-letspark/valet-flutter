import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/base/base_presenter.dart';
import 'package:valet_app/fragment/CheckInTab/Presenter/CheckInTabPresenter.dart';
import 'package:valet_app/fragment/CheckInTab/View/CheckInTabView.dart';

class CheckInTabPresenterImpl extends BasePresenter<CheckInTabView>
    implements CheckInTabPresenter {
  @override
  void initData() {
    // TODO: implement initData
    List<String> role = apiClientImpl.getViewRoles();
    bool isParked = role.contains(Strings.ROLE_PARKED);
    bool isUnParked = role.contains(Strings.ROLE_UNPAKRED);
    getView()?.setPermission(isParked, isUnParked);
  }
}
