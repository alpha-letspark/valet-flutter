import 'package:valet_app/CardLostForm/presenter/CardLossFormPresenter.dart';
import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/LPBaseResponse.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../Data/Response/LoginResponse.dart';
import '../view/CardLossFormDialogView.dart';

class CardLossFormPresenterImpl extends BasePresenter<CardLossFormDialogView>
    implements CardLossFormPresenter {
  @override
  void onSubmitClick(String transcationId, String hookNumber) async {
    // TODO: implement onSubmitClick
    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();

      String clientId = loginResponse?.data?.client_id ?? "";
      String userId = (loginResponse?.data?.id ?? 0).toString();

      BaseResponse baseResponse = await apiClientImpl.cardLoss(
          clientId,
          userId,
          transcationId,
          hookNumber,
          getView()?.getGuestName() ?? "",
          getView()?.getGuestNumber() ?? "",
          getView()?.getFineAmount() ?? "",
          getView()?.getRCPhoto(),
          getView()?.getAadharCardPhoto());
      getView()?.hideProgress();

      if (baseResponse.data != null) {
        LPBaseResponse response = baseResponse.data;
        if (response.status == 1) {
          getView()?.onTranscationSuccess();
          getView()?.showErrorMsg(response.message ?? "");
        } else {
          getView()?.showErrorMsg(response.message ?? "");
        }
      }
    } else {
      getView()?.showOfflineMessage();
    }
  }
}
