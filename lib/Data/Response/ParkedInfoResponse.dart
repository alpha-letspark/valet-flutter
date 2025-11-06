import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/ParkedInfoData.dart';

class ParkedInfoResponse {
  int? status;
  String? message;
  List<ParkedInfoData>? data;
  ParkedInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  ParkedInfoResponse copyWith({
    int? status,
    String? message,
    List<ParkedInfoData>? data,
  }) {
    return ParkedInfoResponse(
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

  factory ParkedInfoResponse.fromJson(Map<String, dynamic> map) {
    return ParkedInfoResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<ParkedInfoData>.from(
              map['data']?.map((x) => ParkedInfoData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ParkedInfoResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkedInfoResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
