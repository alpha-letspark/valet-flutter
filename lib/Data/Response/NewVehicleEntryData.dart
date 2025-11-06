import 'dart:convert';

class NewVehicleEntryData {
  String? client_id;
  String? entry_user_id;
  int? inserted_id;
  int? transaction_id;
  String? entry_time;
  NewVehicleEntryData({
    this.client_id,
    this.entry_user_id,
    this.inserted_id,
    this.transaction_id,
    this.entry_time,
  });

  NewVehicleEntryData copyWith({
    String? client_id,
    String? entry_user_id,
    int? inserted_id,
    int? transaction_id,
    String? entry_time,
  }) {
    return NewVehicleEntryData(
      client_id: client_id ?? this.client_id,
      entry_user_id: entry_user_id ?? this.entry_user_id,
      inserted_id: inserted_id ?? this.inserted_id,
      transaction_id: transaction_id ?? this.transaction_id,
      entry_time: entry_time ?? this.entry_time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': client_id,
      'entry_user_id': entry_user_id,
      'inserted_id': inserted_id,
      'transaction_id': transaction_id,
      'entry_time': entry_time,
    };
  }

  factory NewVehicleEntryData.fromMap(Map<String, dynamic> map) {
    return NewVehicleEntryData(
      client_id: map['client_id'],
      entry_user_id: map['entry_user_id'],
      inserted_id: map['inserted_id']?.toInt(),
      transaction_id: map['transaction_id']?.toInt(),
      entry_time: map['entry_time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewVehicleEntryData.fromJson(String source) =>
      NewVehicleEntryData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewVehicleEntryData(client_id: $client_id, entry_user_id: $entry_user_id, inserted_id: $inserted_id, transaction_id: $transaction_id, entry_time: $entry_time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewVehicleEntryData &&
        other.client_id == client_id &&
        other.entry_user_id == entry_user_id &&
        other.inserted_id == inserted_id &&
        other.transaction_id == transaction_id &&
        other.entry_time == entry_time;
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
        entry_user_id.hashCode ^
        inserted_id.hashCode ^
        transaction_id.hashCode ^
        entry_time.hashCode;
  }
}
