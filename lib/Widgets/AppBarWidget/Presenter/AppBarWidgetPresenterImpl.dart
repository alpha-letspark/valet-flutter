import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/AppBarWidget/Presenter/AppBarWidgetPresenter.dart';
import 'package:valet_app/Widgets/AppBarWidget/View/AppBarWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

class AppBarWidgetPresenterImpl extends BasePresenter<AppBarWidgetView>
    implements AppBarWidgetPresenter {
  @override
  void initData() {
    // TODO: implement initData
    //return apiClientImpl.getLoginData();
    List<String> role = apiClientImpl.getViewRoles();
    bool isNewEntry = role.contains(Strings.ROLE_ENTRY);
    getView()?.setDataAndPermission(apiClientImpl.getLoginData(), isNewEntry);
  }
}
