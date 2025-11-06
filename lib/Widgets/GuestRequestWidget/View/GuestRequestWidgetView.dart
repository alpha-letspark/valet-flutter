import '../../../Data/Response/DriverListData.dart';

abstract class GuestRequestWidgetView {
  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void setDriverListResponse(List<DriverListData> data);

  void setVisibleFieldList(List<String> visible);

  void setMandatoryFieldList(List<String> mandatory);

  DriverListData? getDriverData();

  void onTranscationSuccess();

  void showEtaDialog(List<String?> etaList);
}
