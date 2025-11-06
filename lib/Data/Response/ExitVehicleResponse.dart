import 'dart:convert';

import 'package:valet_app/Data/Response/ExitVehicleData.dart';

class ExitVehicleResponse {
  int? status;
  String? message;
  ExitVehicleData? data;
  ExitVehicleResponse({
    this.status,
    this.message,
    this.data,
  });

  ExitVehicleResponse copyWith({
    int? status,
    String? message,
    ExitVehicleData? data,
  }) {
    return ExitVehicleResponse(
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

  factory ExitVehicleResponse.fromJson(Map<String, dynamic> map) {
    return ExitVehicleResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['data'] != null ? ExitVehicleData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'ExitVehicleResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitVehicleResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
