import 'package:flutter/material.dart';

class Locations {
  late String locationType;
  late String carCount;

  Locations(
    this.locationType,
    this.carCount,
  );
}

class CarDetails {
  late String carName;
  late String carNumber;

  CarDetails(this.carName, this.carNumber);
}
