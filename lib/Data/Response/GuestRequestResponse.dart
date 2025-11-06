import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/GuestRequestData.dart';

class GuestRequestResponse {
  int? status;
  String? message;
  List<GuestRequestData>? data;
  GuestRequestResponse({
    this.status,
    this.message,
    this.data,
  });

  GuestRequestResponse copyWith({
    int? status,
    String? message,
    List<GuestRequestData>? data,
  }) {
    return GuestRequestResponse(
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

  factory GuestRequestResponse.fromJson(Map<String, dynamic> map) {
    return GuestRequestResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<GuestRequestData>.from(
              map['data']?.map((x) => GuestRequestData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'GuestRequestResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GuestRequestResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
