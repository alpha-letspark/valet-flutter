import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/VehicleNameData.dart';

class VehicleNameResponse {
  int? status;
  String? message;
  List<VehicleNameData>? data;
  VehicleNameResponse({
    this.status,
    this.message,
    this.data,
  });

  VehicleNameResponse copyWith({
    int? status,
    String? message,
    List<VehicleNameData>? data,
  }) {
    return VehicleNameResponse(
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

  factory VehicleNameResponse.fromJson(Map<String, dynamic> map) {
    return VehicleNameResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<VehicleNameData>.from(
              map['data']?.map((x) => VehicleNameData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'VehicleNameResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleNameResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
