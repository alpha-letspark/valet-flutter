import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/UnparkedListData.dart';

class UnparkedListResponse {
  int? status;
  String? message;
  List<UnparkedListData>? data;
  UnparkedListResponse({
    this.status,
    this.message,
    this.data,
  });

  UnparkedListResponse copyWith({
    int? status,
    String? message,
    List<UnparkedListData>? data,
  }) {
    return UnparkedListResponse(
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

  factory UnparkedListResponse.fromJson(Map<String, dynamic> map) {
    return UnparkedListResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null
          ? List<UnparkedListData>.from(
              map['data']?.map((x) => UnparkedListData.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UnparkedListResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnparkedListResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
