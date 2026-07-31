import '../../../Data/Response/EntryMenuNumberResponse.dart';

abstract class CheckOutTabView {
  Future<bool> isOnline();

  void setMenuNumberResponse(EntryMenuNumberResponse response);
}
