import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/DriverListData.dart';

class DriverListResponse {
  int? status;
  String? message;
  List<DriverListData>? data;
  DriverListResponse({
    this.status,
    this.message,
    this.data,
  });

  DriverListResponse copyWith({
    int? status,
    String? message,
    List<DriverListData>? data,
  }) {
    return DriverListResponse(
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

  factory DriverListResponse.fromJson(Map<String, dynamic> map) {
    return DriverListResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<DriverListData>.from(
              map['data']?.map((x) => DriverListData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory DriverListResponse.fromJson(String source) =>
  //     DriverListResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'DriverListResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverListResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
