import 'dart:convert';

class ExitByHNData {
  String? client_id;
  String? transaction_id;
  String? hook_number;
  String? entry_time;
  String? vehicle_number;
  String? guest_name;
  String? guest_mobile;
  String? driver;
  String? driver_id;
  String? location;
  String? location_id;
  bool? is_card_based;
  String? parked_by;
  int? parked_by_id;
  String? picked_by;
  int? picked_by_id;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  ExitByHNData({
    this.client_id,
    this.transaction_id,
    this.hook_number,
    this.entry_time,
    this.vehicle_number,
    this.guest_name,
    this.guest_mobile,
    this.driver,
    this.driver_id,
    this.location,
    this.location_id,
    this.is_card_based,
    this.parked_by,
    this.parked_by_id,
    this.picked_by,
    this.picked_by_id,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  ExitByHNData copyWith({
    String? client_id,
    String? transaction_id,
    String? hook_number,
    String? entry_time,
    String? vehicle_number,
    String? guest_name,
    String? guest_mobile,
    String? driver,
    String? driver_id,
    String? location,
    String? location_id,
    bool? is_card_based,
    String? parked_by,
    int? parked_by_id,
    String? picked_by,
    int? picked_by_id,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return ExitByHNData(
      client_id: client_id ?? this.client_id,
      transaction_id: transaction_id ?? this.transaction_id,
      hook_number: hook_number ?? this.hook_number,
      entry_time: entry_time ?? this.entry_time,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      guest_name: guest_name ?? this.guest_name,
      guest_mobile: guest_mobile ?? this.guest_mobile,
      driver: driver ?? this.driver,
      driver_id: driver_id ?? this.driver_id,
      location: location ?? this.location,
      location_id: location_id ?? this.location_id,
      is_card_based: is_card_based ?? this.is_card_based,
      parked_by: parked_by ?? this.parked_by,
      parked_by_id: parked_by_id ?? this.parked_by_id,
      picked_by: picked_by ?? this.picked_by,
      picked_by_id: picked_by_id ?? this.picked_by_id,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      vehicle_color: vehicle_color ?? this.vehicle_color,
      slots: slots ?? this.slots,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': client_id,
      'transaction_id': transaction_id,
      'hook_number': hook_number,
      'entry_time': entry_time,
      'vehicle_number': vehicle_number,
      'guest_name': guest_name,
      'guest_mobile': guest_mobile,
      'driver': driver,
      'driver_id': driver_id,
      'location': location,
      'location_id': location_id,
      'is_card_based': is_card_based,
      'parked_by': parked_by,
      'parked_by_id': parked_by_id,
      'picked_by': picked_by,
      'picked_by_id': picked_by_id,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory ExitByHNData.fromMap(Map<String, dynamic> map) {
    return ExitByHNData(
      client_id: map['client_id'],
      transaction_id: map['transaction_id'],
      hook_number: map['hook_number'],
      entry_time: map['entry_time'],
      vehicle_number: map['vehicle_number'],
      guest_name: map['guest_name'],
      guest_mobile: map['guest_mobile'],
      driver: map['driver'],
      driver_id: map['driver_id'],
      location: map['location'],
      location_id: map['location_id'],
      is_card_based: map['is_card_based'],
      parked_by: map['parked_by'],
      parked_by_id: map['parked_by_id']?.toInt(),
      picked_by: map['picked_by'],
      picked_by_id: map['picked_by_id']?.toInt(),
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExitByHNData.fromJson(String source) =>
      ExitByHNData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExitByHNData(client_id: $client_id, transaction_id: $transaction_id, hook_number: $hook_number, entry_time: $entry_time, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, driver: $driver, driver_id: $driver_id, location: $location, location_id: $location_id, is_card_based: $is_card_based, parked_by: $parked_by, parked_by_id: $parked_by_id, picked_by: $picked_by, picked_by_id: $picked_by_id, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitByHNData &&
        other.client_id == client_id &&
        other.transaction_id == transaction_id &&
        other.hook_number == hook_number &&
        other.entry_time == entry_time &&
        other.vehicle_number == vehicle_number &&
        other.guest_name == guest_name &&
        other.guest_mobile == guest_mobile &&
        other.driver == driver &&
        other.driver_id == driver_id &&
        other.location == location &&
        other.location_id == location_id &&
        other.is_card_based == is_card_based &&
        other.parked_by == parked_by &&
        other.parked_by_id == parked_by_id &&
        other.picked_by == picked_by &&
        other.picked_by_id == picked_by_id &&
        other.vehicle_name == vehicle_name &&
        other.vehicle_color == vehicle_color &&
        other.slots == slots;
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
        transaction_id.hashCode ^
        hook_number.hashCode ^
        entry_time.hashCode ^
        vehicle_number.hashCode ^
        guest_name.hashCode ^
        guest_mobile.hashCode ^
        driver.hashCode ^
        driver_id.hashCode ^
        location.hashCode ^
        location_id.hashCode ^
        is_card_based.hashCode ^
        parked_by.hashCode ^
        parked_by_id.hashCode ^
        picked_by.hashCode ^
        picked_by_id.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }
}
