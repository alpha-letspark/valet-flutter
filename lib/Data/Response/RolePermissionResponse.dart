import 'dart:convert';

import 'package:flutter/foundation.dart';

class RolePermissionResponse {
  int? status;
  String? message;
  List<String?>? data;
  RolePermissionResponse({
    this.status,
    this.message,
    this.data,
  });

  RolePermissionResponse copyWith({
    int? status,
    String? message,
    List<String?>? data,
  }) {
    return RolePermissionResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }

  factory RolePermissionResponse.fromJson(Map<String, dynamic> map) {
    return RolePermissionResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? List<String?>.from(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'RolePermissionResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RolePermissionResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
