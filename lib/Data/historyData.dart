import 'package:flutter/cupertino.dart';

class History {
  String? vehicleNumber;
  String? vehicleName;
  String? guestName;
  String? guestNumber;
  String? dateIn;
  String? timeIn;
  String? valetDriverIn;
  String? dateOut;
  String? timeOut;
  String? valetDriverOut;
  String? historyLocation;
  String? hookNumber;
  String? valuableThing;
  String? notes;
  String? eTA;
  History(
      this.vehicleNumber,
      this.vehicleName,
      this.guestName,
      this.guestNumber,
      this.timeIn,
      this.dateIn,
      this.valetDriverIn,
      this.timeOut,
      this.dateOut,
      this.valetDriverOut,
      this.valuableThing,
      this.hookNumber,
      this.historyLocation,
      this.notes,
      this.eTA);
}
