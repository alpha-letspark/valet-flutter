import 'dart:convert';

import 'package:valet_app/Data/Response/HistoryCountData.dart';

class HistoryCountResponse {
  int? status;
  String? message;
  HistoryCountData? data;
  HistoryCountResponse({
    this.status,
    this.message,
    this.data,
  });

  HistoryCountResponse copyWith({
    int? status,
    String? message,
    HistoryCountData? data,
  }) {
    return HistoryCountResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory HistoryCountResponse.fromJson(Map<String, dynamic> map) {
    return HistoryCountResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? HistoryCountData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'HistoryCountResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryCountResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
