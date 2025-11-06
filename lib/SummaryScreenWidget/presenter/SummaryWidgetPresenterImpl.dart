import 'package:valet_app/Data/Response/SummaryData.dart';
import 'package:valet_app/Preferences/preferences.dart';
import 'package:valet_app/SummaryScreenWidget/presenter/SummaryWidgetPresenter.dart';
import 'package:valet_app/SummaryScreenWidget/view/SummaryScreenWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

class SummaryWidgetPresenterImpl extends BasePresenter<SummaryScreenWidgetView>
    implements SummaryWidgetPresenter {
  @override
  void getData(SummaryData data) async {
    // TODO: implement getData
    List<String> visible = [];

    if (data.is_card_based ?? false) {
      visible = await Preferences.getListOfString(Preferences.CARD_PERMISSION);
    } else {
      visible = await Preferences.getListOfString(Preferences.SMS_PERMISSIONS);
    }

    getView()?.setVisibleFieldList(visible);
  }
}
