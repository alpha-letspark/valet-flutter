import 'dart:io';

abstract class CardLossFormDialogView {
  String getGuestName();
  String getGuestNumber();
  String getFineAmount();
  File? getRCPhoto();
  File? getAadharCardPhoto();

  void showErrorMsg(String? msg);

  Future<bool> isOnline();

  void showOfflineMessage();

  void showProgress();

  void hideProgress();

  void onTranscationSuccess();
}
