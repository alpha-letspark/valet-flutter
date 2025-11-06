import 'package:valet_app/Data/Response/ExitListData.dart';

abstract class ExitListWidgetPresenter {
  void initData(ExitListData data);

  void getDriverList();

  void onSubmitClick(ExitListData data);

  void exitTranscation(ExitListData data,
      {String pinNo = '', String password = ''});

  void markReady(ExitListData data);

  void markRollback(ExitListData data);

  void onExitManuallyClicked(ExitListData data);
}
