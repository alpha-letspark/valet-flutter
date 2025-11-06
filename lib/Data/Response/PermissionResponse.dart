import 'dart:convert';

import 'package:valet_app/Data/Response/PermissionData.dart';

class PermissionResponse {
  int? status;
  String? message;
  PermissionData? data;
  PermissionResponse({
    this.status,
    this.message,
    this.data,
  });

  PermissionResponse copyWith({
    int? status,
    String? message,
    PermissionData? data,
  }) {
    return PermissionResponse(
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

  factory PermissionResponse.fromJson(Map<String, dynamic> map) {
    return PermissionResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? PermissionData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory PermissionResponse.fromJson(String source) =>
  //     PermissionResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'PermissionResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PermissionResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
