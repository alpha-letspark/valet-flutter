import 'dart:convert';

import 'package:valet_app/Data/Response/ExitByHNData.dart';

class PostExitByHNResponse {
  int? status;
  String? message;
  ExitByHNData? data;

  PostExitByHNResponse({
    this.status,
    this.message,
    this.data,
  });

  PostExitByHNResponse copyWith({
    int? status,
    String? message,
    ExitByHNData? data,
  }) {
    return PostExitByHNResponse(
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

  factory PostExitByHNResponse.fromJson(Map<String, dynamic> map) {
    return PostExitByHNResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? ExitByHNData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PostExitByHNResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostExitByHNResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
