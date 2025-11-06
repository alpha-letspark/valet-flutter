import 'package:valet_app/Data/Response/ExitByHNData.dart';

import '../../../Data/Response/ParkingLocationData.dart';

abstract class ExitByHNWidgetPresenter {
  void getParkingLocationList();

  void onExitClick(ExitByHNData data);

  void getDriverList();

  void exitTranscation(ExitByHNData data,
      {String pinNo = '', String password = ''});

  void updateParkingLocation(ParkingLocationData data, String transactionId);
}
