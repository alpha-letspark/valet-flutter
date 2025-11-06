import 'dart:convert';

import 'package:valet_app/Data/Response/NewVehicleEntryData.dart';

class UpdateVehicleEntryResponse {
  int? status;
  String? message;

  UpdateVehicleEntryResponse({
    this.status,
    this.message,
  });

  UpdateVehicleEntryResponse copyWith({
    int? status,
    String? message,
  }) {
    return UpdateVehicleEntryResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory UpdateVehicleEntryResponse.fromJson(Map<String, dynamic> map) {
    return UpdateVehicleEntryResponse(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UpdateVehicleEntryResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpdateVehicleEntryResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;

  factory UpdateVehicleEntryResponse.fromMap(Map<String, dynamic> map) {
    return UpdateVehicleEntryResponse(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }
}
