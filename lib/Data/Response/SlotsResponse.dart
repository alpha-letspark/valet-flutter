import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/SlotsData.dart';

class SlotsResponse {
  int? status;
  String? message;
  List<SlotsData>? data;
  SlotsResponse({
    this.status,
    this.message,
    this.data,
  });

  SlotsResponse copyWith({
    int? status,
    String? message,
    List<SlotsData>? data,
  }) {
    return SlotsResponse(
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

  factory SlotsResponse.fromJson(Map<String, dynamic> map) {
    return SlotsResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<SlotsData>.from(map['data']?.map((x) => SlotsData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'SlotsResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SlotsResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
