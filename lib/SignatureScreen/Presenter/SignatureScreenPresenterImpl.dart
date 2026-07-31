import 'package:valet_app/Data/BaseResponse.dart';
import 'package:valet_app/Data/Response/LoginResponse.dart';
import 'package:valet_app/Data/Response/SignatureResponse.dart';
import 'package:valet_app/SignatureScreen/Presenter/SignatureScreenPresenter.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../View/SignatureScreenView.dart';

class SignatureScreenPresenterImpl extends BasePresenter<SignatureScreenView>
    implements SignatureScreenPresenter {
  @override
  void initData() async {
    // TODO: implement initData

    bool isOnline = await getView()?.isOnline() ?? false;
    if (isOnline) {
      getView()?.showProgress();
      LoginResponse? loginResponse = apiClientImpl.getLoginData();
      BaseResponse baseResponse = await apiClientImpl
          .getSignatureTC(loginResponse?.data?.client_id ?? "");
      SignatureResponse? response = baseResponse.data;
      if (response != null) {
        getView()?.setSignatureData(response.data);
      }

      getView()?.hideProgress();
    }
  }
}
