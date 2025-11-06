import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/HistoryData.dart';

class HistoryResponse {
  int? status;
  String? message;
  List<HistoryData>? data;
  HistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  HistoryResponse copyWith({
    int? status,
    String? message,
    List<HistoryData>? data,
  }) {
    return HistoryResponse(
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

  factory HistoryResponse.fromJson(Map<String, dynamic> map) {
    return HistoryResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<HistoryData>.from(
              map['data']?.map((x) => HistoryData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'HistoryResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
