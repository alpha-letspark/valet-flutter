import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ExitListData.dart';

class ExitListResponse {
  int? status;
  String? message;
  List<ExitListData>? data;
  ExitListResponse({
    this.status,
    this.message,
    this.data,
  });

  ExitListResponse copyWith({
    int? status,
    String? message,
    List<ExitListData>? data,
  }) {
    return ExitListResponse(
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

  factory ExitListResponse.fromJson(Map<String, dynamic> map) {
    return ExitListResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ExitListData>.from(
              map['data']?.map((x) => ExitListData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExitListResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitListResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
