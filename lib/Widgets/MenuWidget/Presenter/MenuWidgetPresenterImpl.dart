import 'package:valet_app/Util/Strings.dart';
import 'package:valet_app/Widgets/MenuWidget/Presenter/MenuWidgetPresenter.dart';
import 'package:valet_app/Widgets/MenuWidget/View/MenuWidgetView.dart';
import 'package:valet_app/base/base_presenter.dart';

import '../../../Data/ImageUploadData.dart';

class MenuWidgetPresenterImpl extends BasePresenter<MenuWidgetView>
    implements MenuWidgetPresenter {
  @override
  void getUploadPhotoCount() async {
    // TODO: implement getUploadPhotoCount
    List<String> roles = apiClientImpl.getViewRoles();

    bool isHistory = roles.contains(Strings.ROLE_HISTORY);
    bool isSetting = roles.contains(Strings.ROLE_SETTING);
    bool isParked = roles.contains(Strings.ROLE_PARKED);
    getView()?.setPermission(isHistory, isSetting, isParked);
    int count = await db.getPendingPhotoCount();
    getView()?.showUploadPhotoCount(count);
  }

  @override
  void uploadDocument() async {
    bool isOnline = await getView()?.isOnline() ?? false;

    if (isOnline) {
      List<ImageUploadData>? photosToUpload =
          await db.getAllPendingPhotoToUpload();
      await apiClientImpl.uploadPhotos(photosToUpload ?? []);
    } else {
      getView()?.showOfflineMessage();
    }
  }
}
