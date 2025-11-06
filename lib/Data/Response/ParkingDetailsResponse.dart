import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ParkingDetailsData.dart';

class ParkingDetailsResponse {
  int? status;
  String? message;
  List<ParkingDetailsData?>? data;
  ParkingDetailsResponse({
    this.status,
    this.message,
    this.data,
  });

  ParkingDetailsResponse copyWith({
    int? status,
    String? message,
    List<ParkingDetailsData?>? data,
  }) {
    return ParkingDetailsResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x?.toMap()).toList(),
    };
  }

  factory ParkingDetailsResponse.fromJson(Map<String, dynamic> map) {
    return ParkingDetailsResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ParkingDetailsData?>.from(
              map['data']?.map((x) => ParkingDetailsData?.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory ParkingDetailsResponse.fromJson(String source) =>
  //     ParkingDetailsResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'ParkingDetailsResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingDetailsResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory ParkingDetailsResponse.fromMap(Map<String, dynamic> map) {
    return ParkingDetailsResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ParkingDetailsData?>.from(
              map['data']?.map((x) => ParkingDetailsData?.fromMap(x)))
          : null,
    );
  }
}
