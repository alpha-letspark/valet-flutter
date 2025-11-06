import 'dart:convert';

class ScanNumberPlateResponse {
  int? status;
  String? message;
  String? file_name;
  String? vehicle_number;
  ScanNumberPlateResponse({
    this.status,
    this.message,
    this.file_name,
    this.vehicle_number,
  });

  ScanNumberPlateResponse copyWith({
    int? status,
    String? message,
    String? file_name,
    String? vehicle_number,
  }) {
    return ScanNumberPlateResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      file_name: file_name ?? this.file_name,
      vehicle_number: vehicle_number ?? this.vehicle_number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'file_name': file_name,
      'vehicle_number': vehicle_number,
    };
  }

  factory ScanNumberPlateResponse.fromJson(Map<String, dynamic> map) {
    return ScanNumberPlateResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      file_name: map['file_name'],
      vehicle_number: map['vehicle_number'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ScanNumberPlateResponse(status: $status, message: $message, file_name: $file_name, vehicle_number: $vehicle_number)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScanNumberPlateResponse &&
        other.status == status &&
        other.message == message &&
        other.file_name == file_name &&
        other.vehicle_number == vehicle_number;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        file_name.hashCode ^
        vehicle_number.hashCode;
  }

  factory ScanNumberPlateResponse.fromMap(Map<String, dynamic> map) {
    return ScanNumberPlateResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      file_name: map['file_name'],
      vehicle_number: map['vehicle_number'],
    );
  }
}
