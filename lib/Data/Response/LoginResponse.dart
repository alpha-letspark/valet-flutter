import 'dart:convert';

import 'package:valet_app/Data/Response/LoginData.dart';

class LoginResponse {
  String? status;
  String? message;
  String? access_token;
  String? token_type;
  int? expires_in;
  LoginData? data;

  LoginResponse({
    this.status,
    this.message,
    this.access_token,
    this.token_type,
    this.expires_in,
    this.data,
  });

  LoginResponse copyWith({
    String? status,
    String? message,
    String? access_token,
    String? token_type,
    int? expires_in,
    LoginData? data,
  }) {
    return LoginResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      access_token: access_token ?? this.access_token,
      token_type: token_type ?? this.token_type,
      expires_in: expires_in ?? this.expires_in,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'access_token': access_token,
      'token_type': token_type,
      'expires_in': expires_in,
      'data': data?.toMap(),
    };
  }

  factory LoginResponse.fromJson(Map<String, dynamic> map) {
    return LoginResponse(
      status: map['status'],
      message: map['message'],
      access_token: map['access_token'],
      token_type: map['token_type'],
      expires_in: map['expires_in'],
      data: map['data'] != null ? LoginData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoginResponse(status: $status, message: $message, access_token: $access_token, token_type: $token_type, expires_in: $expires_in, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginResponse &&
        other.status == status &&
        other.message == message &&
        other.access_token == access_token &&
        other.token_type == token_type &&
        other.expires_in == expires_in &&
        other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        access_token.hashCode ^
        token_type.hashCode ^
        expires_in.hashCode ^
        data.hashCode;
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      status: map['status'],
      message: map['message'],
      access_token: map['access_token'],
      token_type: map['token_type'],
      expires_in: map['expires_in'],
      data: map['data'] != null ? LoginData.fromMap(map['data']) : null,
    );
  }
}
