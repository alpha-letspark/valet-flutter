import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ParkingLocationData.dart';

class ParkingLocationResponse {
  int? status;
  String? message;
  List<ParkingLocationData>? data;
  ParkingLocationResponse({
    this.status,
    this.message,
    this.data,
  });

  ParkingLocationResponse copyWith({
    int? status,
    String? message,
    List<ParkingLocationData>? data,
  }) {
    return ParkingLocationResponse(
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

  factory ParkingLocationResponse.fromJson(Map<String, dynamic> map) {
    return ParkingLocationResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ParkingLocationData>.from(
              map['data']?.map((x) => ParkingLocationData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ParkingLocationResponse.fromJson(String source) =>
  //     ParkingLocationResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ParkingLocationResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingLocationResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory ParkingLocationResponse.fromMap(Map<String, dynamic> map) {
    return ParkingLocationResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ParkingLocationData>.from(
              map['data']?.map((x) => ParkingLocationData.fromMap(x)))
          : null,
    );
  }
}
