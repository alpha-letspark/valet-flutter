import '../../../Data/Response/ParkingDetailsData.dart';

abstract class TapCarDialogPresenter {
  void getParkingLocationList();

  void onSubmitClick();

  void onExitManuallyClicked(ParkingDetailsData data);
}
