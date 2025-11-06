import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/VehicleColorData.dart';

class VehicleColorResponse {
  int? status;
  String? message;
  List<VehicleColorData>? data;
  VehicleColorResponse({
    this.status,
    this.message,
    this.data,
  });

  VehicleColorResponse copyWith({
    int? status,
    String? message,
    List<VehicleColorData>? data,
  }) {
    return VehicleColorResponse(
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

  factory VehicleColorResponse.fromJson(Map<String, dynamic> map) {
    return VehicleColorResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<VehicleColorData>.from(
              map['data']?.map((x) => VehicleColorData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'VehicleColorResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleColorResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
