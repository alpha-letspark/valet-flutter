import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ParkedInfoVehicleDetails.dart';

class ParkedInfoData {
  String? name;
  String? color_code;
  int? total;
  List<ParkedInfoDataVehicleDetails>? vehicle_details;
  ParkedInfoData({
    this.name,
    this.color_code,
    this.total,
    this.vehicle_details,
  });

  ParkedInfoData copyWith({
    String? name,
    String? color_code,
    int? total,
    List<ParkedInfoDataVehicleDetails>? vehicle_details,
  }) {
    return ParkedInfoData(
      name: name ?? this.name,
      color_code: color_code ?? this.color_code,
      total: total ?? this.total,
      vehicle_details: vehicle_details ?? this.vehicle_details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color_code': color_code,
      'total': total,
      'vehicle_details': vehicle_details?.map((x) => x.toMap()).toList(),
    };
  }

  factory ParkedInfoData.fromMap(Map<String, dynamic> map) {
    return ParkedInfoData(
      name: map['name'],
      color_code: map['color_code'],
      total: map['total']?.toInt(),
      vehicle_details: map['vehicle_details'] != null
          ? List<ParkedInfoDataVehicleDetails>.from(map['vehicle_details']
              ?.map((x) => ParkedInfoDataVehicleDetails.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkedInfoData.fromJson(String source) =>
      ParkedInfoData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParkedInfoData(name: $name, color_code: $color_code, total: $total, vehicle_details: $vehicle_details)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkedInfoData &&
        other.name == name &&
        other.color_code == color_code &&
        other.total == total &&
        listEquals(other.vehicle_details, vehicle_details);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        color_code.hashCode ^
        total.hashCode ^
        vehicle_details.hashCode;
  }
}
