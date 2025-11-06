import 'package:valet_app/Data/Response/DriverListData.dart';
import 'package:valet_app/Data/Response/GuestRequestData.dart';

abstract class GuestRequestWidgetPresenter {
  void initData(GuestRequestData data);

  void getDriverList();

  void onSubmitClick(GuestRequestData data);

  void assignDriver(GuestRequestData guestRequestData, DriverListData data);

  void acceptRequest(String eta, GuestRequestData data);
}
