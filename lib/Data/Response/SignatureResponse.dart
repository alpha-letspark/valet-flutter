import 'dart:convert';

import 'package:valet_app/Data/Response/SignatureData.dart';

class SignatureResponse {
  int? status;
  String? message;
  SignatureData? data;
  SignatureResponse({
    this.status,
    this.message,
    this.data,
  });

  SignatureResponse copyWith({
    int? status,
    String? message,
    SignatureData? data,
  }) {
    return SignatureResponse(
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

  factory SignatureResponse.fromJson(Map<String, dynamic> map) {
    return SignatureResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? SignatureData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory SignatureResponse.fromJson(String source) =>
  //     SignatureResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SignatureResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignatureResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory SignatureResponse.fromMap(Map<String, dynamic> map) {
    return SignatureResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? SignatureData.fromMap(map['data']) : null,
    );
  }
}
