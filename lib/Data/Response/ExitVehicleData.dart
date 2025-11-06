import 'dart:convert';

class ExitVehicleData {
  int? id;
  String? transaction_id;
  String? vehicle_number;
  String? entry_time;
  String? exit_time;
  String? exit_user_id;
  ExitVehicleData({
    this.id,
    this.transaction_id,
    this.vehicle_number,
    this.entry_time,
    this.exit_time,
    this.exit_user_id,
  });

  ExitVehicleData copyWith({
    int? id,
    String? transaction_id,
    String? vehicle_number,
    String? entry_time,
    String? exit_time,
    String? exit_user_id,
  }) {
    return ExitVehicleData(
      id: id ?? this.id,
      transaction_id: transaction_id ?? this.transaction_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      entry_time: entry_time ?? this.entry_time,
      exit_time: exit_time ?? this.exit_time,
      exit_user_id: exit_user_id ?? this.exit_user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transaction_id': transaction_id,
      'vehicle_number': vehicle_number,
      'entry_time': entry_time,
      'exit_time': exit_time,
      'exit_user_id': exit_user_id,
    };
  }

  factory ExitVehicleData.fromMap(Map<String, dynamic> map) {
    return ExitVehicleData(
      id: map['id']?.toInt(),
      transaction_id: map['transaction_id'],
      vehicle_number: map['vehicle_number'],
      entry_time: map['entry_time'],
      exit_time: map['exit_time'],
      exit_user_id: map['exit_user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExitVehicleData.fromJson(String source) =>
      ExitVehicleData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExitVehicleData(id: $id, transaction_id: $transaction_id, vehicle_number: $vehicle_number, entry_time: $entry_time, exit_time: $exit_time, exit_user_id: $exit_user_id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitVehicleData &&
        other.id == id &&
        other.transaction_id == transaction_id &&
        other.vehicle_number == vehicle_number &&
        other.entry_time == entry_time &&
        other.exit_time == exit_time &&
        other.exit_user_id == exit_user_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        transaction_id.hashCode ^
        vehicle_number.hashCode ^
        entry_time.hashCode ^
        exit_time.hashCode ^
        exit_user_id.hashCode;
  }
}
