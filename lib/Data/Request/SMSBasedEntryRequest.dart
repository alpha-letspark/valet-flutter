import 'dart:convert';

import 'package:flutter/foundation.dart';

class SMSBasedEntryRequest {
  String? client_id;
  String? entry_user_id;
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
  String? guest_name;
  String? guest_mobile;
  String? guest_email;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  SMSBasedEntryRequest({
    this.client_id,
    this.entry_user_id,
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
    this.guest_name,
    this.guest_mobile,
    this.guest_email,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  SMSBasedEntryRequest copyWith({
    String? client_id,
    String? entry_user_id,
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
    String? guest_name,
    String? guest_mobile,
    String? guest_email,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return SMSBasedEntryRequest(
      client_id: client_id ?? this.client_id,
      entry_user_id: entry_user_id ?? this.entry_user_id,
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
      guest_name: guest_name ?? this.guest_name,
      guest_mobile: guest_mobile ?? this.guest_mobile,
      guest_email: guest_email ?? this.guest_email,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      vehicle_color: vehicle_color ?? this.vehicle_color,
      slots: slots ?? this.slots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'entry_user_id': entry_user_id,
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
      'guest_name': guest_name,
      'guest_mobile': guest_mobile,
      'guest_email': guest_email,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory SMSBasedEntryRequest.fromMap(Map<String, dynamic> map) {
    return SMSBasedEntryRequest(
      client_id: map['client_id'],
      entry_user_id: map['entry_user_id'],
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
      guest_name: map['guest_name'],
      guest_mobile: map['guest_mobile'],
      guest_email: map['guest_email'],
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  factory SMSBasedEntryRequest.fromJson(String source) =>
      SMSBasedEntryRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SMSBasedEntryRequest(client_id: $client_id, entry_user_id: $entry_user_id, vehicle_number: $vehicle_number, vehicle_type: $vehicle_type, valuable: $valuable, valuable_things: $valuable_things, image_names: $image_names, driver: $driver, location: $location, hook_number: $hook_number, notes: $notes, is_parked: $is_parked, guest_name: $guest_name, guest_mobile: $guest_mobile, guest_email: $guest_email, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SMSBasedEntryRequest &&
        other.client_id == client_id &&
        other.entry_user_id == entry_user_id &&
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
        other.guest_name == guest_name &&
        other.guest_mobile == guest_mobile &&
        other.guest_email == guest_email &&
        other.vehicle_name == vehicle_name &&
        other.vehicle_color == vehicle_color &&
        other.slots == slots;
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
        entry_user_id.hashCode ^
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
        guest_name.hashCode ^
        guest_mobile.hashCode ^
        guest_email.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }
}
