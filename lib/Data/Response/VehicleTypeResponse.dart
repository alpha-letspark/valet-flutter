import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/VehicleTypeData.dart';

class VehicleTypeResponse {
  int? status;
  String? message;
  List<VehicleTypeData>? data;
  VehicleTypeResponse({
    this.status,
    this.message,
    this.data,
  });

  VehicleTypeResponse copyWith({
    int? status,
    String? message,
    List<VehicleTypeData>? data,
  }) {
    return VehicleTypeResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory VehicleTypeResponse.fromJson(Map<String, dynamic> map) {
    return VehicleTypeResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<VehicleTypeData>.from(
              map['data']?.map((x) => VehicleTypeData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory VehicleTypeResponse.fromJson(String source) =>
  //     VehicleTypeResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'VehicleTypeResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleTypeResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory VehicleTypeResponse.fromMap(Map<String, dynamic> map) {
    return VehicleTypeResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<VehicleTypeData>.from(
              map['data']?.map((x) => VehicleTypeData.fromMap(x)))
          : null,
    );
  }
}
