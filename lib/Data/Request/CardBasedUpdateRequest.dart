import 'dart:convert';

import 'package:flutter/foundation.dart';

class CardBasedUpdateRequest {
  String? client_id;
  String? entry_user_id;
  String? transaction_id;
  String? vehicle_number;
  String? vehicle_type;
  String? valuable;
  String? valuable_things;
  List<String?>? image_names;
  String? driver;
  String? location;
  String? hook_number;
  String? notes;
  String? is_parked;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  CardBasedUpdateRequest({
    this.client_id,
    this.entry_user_id,
    this.transaction_id,
    this.vehicle_number,
    this.vehicle_type,
    this.valuable,
    this.valuable_things,
    this.image_names,
    this.driver,
    this.location,
    this.hook_number,
    this.notes,
    this.is_parked,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  CardBasedUpdateRequest copyWith({
    String? client_id,
    String? entry_user_id,
    String? transaction_id,
    String? vehicle_number,
    String? vehicle_type,
    String? valuable,
    String? valuable_things,
    List<String?>? image_names,
    String? driver,
    String? location,
    String? hook_number,
    String? notes,
    String? is_parked,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return CardBasedUpdateRequest(
      client_id: client_id ?? this.client_id,
      entry_user_id: entry_user_id ?? this.entry_user_id,
      transaction_id: transaction_id ?? this.transaction_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      valuable: valuable ?? this.valuable,
      valuable_things: valuable_things ?? this.valuable_things,
      image_names: image_names ?? this.image_names,
      driver: driver ?? this.driver,
      location: location ?? this.location,
      hook_number: hook_number ?? this.hook_number,
      notes: notes ?? this.notes,
      is_parked: is_parked ?? this.is_parked,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      vehicle_color: vehicle_color ?? this.vehicle_color,
      slots: slots ?? this.slots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'entry_user_id': entry_user_id,
      'transaction_id': transaction_id,
      'vehicle_number': vehicle_number,
      'vehicle_type': vehicle_type,
      'valuable': valuable,
      'valuable_things': valuable_things,
      'image_names': image_names,
      'driver': driver,
      'location': location,
      'hook_number': hook_number,
      'notes': notes,
      'is_parked': is_parked,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory CardBasedUpdateRequest.fromMap(Map<String, dynamic> map) {
    return CardBasedUpdateRequest(
      client_id: map['client_id'],
      entry_user_id: map['entry_user_id'],
      transaction_id: map['transaction_id'],
      vehicle_number: map['vehicle_number'],
      vehicle_type: map['vehicle_type'],
      valuable: map['valuable'],
      valuable_things: map['valuable_things'],
      image_names: map['image_names'] != null
          ? List<String?>.from(map['image_names'])
          : null,
      driver: map['driver'],
      location: map['location'],
      hook_number: map['hook_number'],
      notes: map['notes'],
      is_parked: map['is_parked'],
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory CardBasedUpdateRequest.fromJson(String source) =>
      CardBasedUpdateRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardBasedUpdateRequest(client_id: $client_id, entry_user_id: $entry_user_id, transaction_id: $transaction_id, vehicle_number: $vehicle_number, vehicle_type: $vehicle_type, valuable: $valuable, valuable_things: $valuable_things, image_names: $image_names, driver: $driver, location: $location, hook_number: $hook_number, notes: $notes, is_parked: $is_parked, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardBasedUpdateRequest &&
        other.client_id == client_id &&
        other.entry_user_id == entry_user_id &&
        other.transaction_id == transaction_id &&
        other.vehicle_number == vehicle_number &&
        other.vehicle_type == vehicle_type &&
        other.valuable == valuable &&
        other.valuable_things == valuable_things &&
        listEquals(other.image_names, image_names) &&
        other.driver == driver &&
        other.location == location &&
        other.hook_number == hook_number &&
        other.notes == notes &&
        other.is_parked == is_parked &&
        other.vehicle_name == vehicle_name &&
        other.vehicle_color == vehicle_color &&
        other.slots == slots;
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
        entry_user_id.hashCode ^
        transaction_id.hashCode ^
        vehicle_number.hashCode ^
        vehicle_type.hashCode ^
        valuable.hashCode ^
        valuable_things.hashCode ^
        image_names.hashCode ^
        driver.hashCode ^
        location.hashCode ^
        hook_number.hashCode ^
        notes.hashCode ^
        is_parked.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': client_id,
      'entry_user_id': entry_user_id,
      'transaction_id': transaction_id,
      'vehicle_number': vehicle_number,
      'vehicle_type': vehicle_type,
      'valuable': valuable,
      'valuable_things': valuable_things,
      'image_names': image_names,
      'driver': driver,
      'location': location,
      'hook_number': hook_number,
      'notes': notes,
      'is_parked': is_parked,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }
}
