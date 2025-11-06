import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/SummaryData.dart';

class SummaryResponse {
  int? status;
  String? message;
  List<SummaryData>? data;
  SummaryResponse({
    this.status,
    this.message,
    this.data,
  });

  SummaryResponse copyWith({
    int? status,
    String? message,
    List<SummaryData>? data,
  }) {
    return SummaryResponse(
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

  factory SummaryResponse.fromJson(Map<String, dynamic> map) {
    return SummaryResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<SummaryData>.from(
              map['data']?.map((x) => SummaryData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'SummaryResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummaryResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
