import 'dart:convert';

import 'package:valet_app/Data/Response/SettingData.dart';

class SettingResponse {
  int? status;
  String? message;
  SettingData? data;
  SettingResponse({
    this.status,
    this.message,
    this.data,
  });

  SettingResponse copyWith({
    int? status,
    String? message,
    SettingData? data,
  }) {
    return SettingResponse(
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

  factory SettingResponse.fromJson(Map<String, dynamic> map) {
    return SettingResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? SettingData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'SettingResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory SettingResponse.fromMap(Map<String, dynamic> map) {
    return SettingResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? SettingData.fromMap(map['data']) : null,
    );
  }
}
