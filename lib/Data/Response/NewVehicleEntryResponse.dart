import 'dart:convert';

import 'package:valet_app/Data/Response/NewVehicleEntryData.dart';

class NewVehicleEntryResponse {
  int? status;
  String? message;
  NewVehicleEntryData? data;
  NewVehicleEntryResponse({
    this.status,
    this.message,
    this.data,
  });

  NewVehicleEntryResponse copyWith({
    int? status,
    String? message,
    NewVehicleEntryData? data,
  }) {
    return NewVehicleEntryResponse(
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

  factory NewVehicleEntryResponse.fromJson(Map<String, dynamic> map) {
    return NewVehicleEntryResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data:
          map['data'] != null ? NewVehicleEntryData.fromMap(map['data']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'NewVehicleEntryResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewVehicleEntryResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
