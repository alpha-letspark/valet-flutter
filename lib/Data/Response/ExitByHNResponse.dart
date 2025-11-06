import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ExitByHNData.dart';

class ExitByHNResponse {
  int? status;
  String? message;
  List<ExitByHNData>? data;
  ExitByHNResponse({
    this.status,
    this.message,
    this.data,
  });

  ExitByHNResponse copyWith({
    int? status,
    String? message,
    List<ExitByHNData>? data,
  }) {
    return ExitByHNResponse(
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

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExitByHNResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitByHNResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory ExitByHNResponse.fromJson(Map<String, dynamic> map) {
    return ExitByHNResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ExitByHNData>.from(
              map['data']?.map((x) => ExitByHNData.fromMap(x)))
          : null,
    );
  }
}
