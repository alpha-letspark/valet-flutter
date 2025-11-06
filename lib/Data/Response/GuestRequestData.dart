import 'dart:convert';

import 'package:flutter/foundation.dart';

class GuestRequestData {
  String? transaction_id;
  String? vehicle_number;
  String? guest_name;
  String? guest_mobile;
  String? guest_email;
  String? entry_time;
  String? valuable;
  String? valuable_things;
  String? notes;
  String? hook_number;
  String? vehicle_type;
  String? driver;
  String? location;
  String? is_parked;
  List<String>? vehicle_photo;
  List<String>? thumbnail_photo;
  String? searchString;
  String? driver_id;
  String? location_id;
  String? vehicle_type_id;
  String? arrival_time;
  bool? eta_extend;
  bool? is_card_based;
  String? parked_by;
  int? parked_by_id;
  String? picked_by;
  int? picked_by_id;
  List<String?>? eta_variable;
  String? eta_minutes;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  GuestRequestData({
    this.transaction_id,
    this.vehicle_number,
    this.guest_name,
    this.guest_mobile,
    this.guest_email,
    this.entry_time,
    this.valuable,
    this.valuable_things,
    this.notes,
    this.hook_number,
    this.vehicle_type,
    this.driver,
    this.location,
    this.is_parked,
    this.vehicle_photo,
    this.thumbnail_photo,
    this.searchString,
    this.driver_id,
    this.location_id,
    this.vehicle_type_id,
    this.arrival_time,
    this.eta_extend,
    this.is_card_based,
    this.parked_by,
    this.parked_by_id,
    this.picked_by,
    this.picked_by_id,
    this.eta_variable,
    this.eta_minutes,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  GuestRequestData copyWith({
    String? transaction_id,
    String? vehicle_number,
    String? guest_name,
    String? guest_mobile,
    String? guest_email,
    String? entry_time,
    String? valuable,
    String? valuable_things,
    String? notes,
    String? hook_number,
    String? vehicle_type,
    String? driver,
    String? location,
    String? is_parked,
    List<String>? vehicle_photo,
    List<String>? thumbnail_photo,
    String? searchString,
    String? driver_id,
    String? location_id,
    String? vehicle_type_id,
    String? arrival_time,
    bool? eta_extend,
    bool? is_card_based,
    String? parked_by,
    int? parked_by_id,
    String? picked_by,
    int? picked_by_id,
    List<String?>? eta_variable,
    String? eta_minutes,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return GuestRequestData(
      transaction_id: transaction_id ?? this.transaction_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      guest_name: guest_name ?? this.guest_name,
      guest_mobile: guest_mobile ?? this.guest_mobile,
      guest_email: guest_email ?? this.guest_email,
      entry_time: entry_time ?? this.entry_time,
      valuable: valuable ?? this.valuable,
      valuable_things: valuable_things ?? this.valuable_things,
      notes: notes ?? this.notes,
      hook_number: hook_number ?? this.hook_number,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      driver: driver ?? this.driver,
      location: location ?? this.location,
      is_parked: is_parked ?? this.is_parked,
      vehicle_photo: vehicle_photo ?? this.vehicle_photo,
      thumbnail_photo: thumbnail_photo ?? this.thumbnail_photo,
      searchString: searchString ?? this.searchString,
      driver_id: driver_id ?? this.driver_id,
      location_id: location_id ?? this.location_id,
      vehicle_type_id: vehicle_type_id ?? this.vehicle_type_id,
      arrival_time: arrival_time ?? this.arrival_time,
      eta_extend: eta_extend ?? this.eta_extend,
      is_card_based: is_card_based ?? this.is_card_based,
      parked_by: parked_by ?? this.parked_by,
      parked_by_id: parked_by_id ?? this.parked_by_id,
      picked_by: picked_by ?? this.picked_by,
      picked_by_id: picked_by_id ?? this.picked_by_id,
      eta_variable: eta_variable ?? this.eta_variable,
      eta_minutes: eta_minutes ?? this.eta_minutes,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      vehicle_color: vehicle_color ?? this.vehicle_color,
      slots: slots ?? this.slots,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transaction_id': transaction_id,
      'vehicle_number': vehicle_number,
      'guest_name': guest_name,
      'guest_mobile': guest_mobile,
      'guest_email': guest_email,
      'entry_time': entry_time,
      'valuable': valuable,
      'valuable_things': valuable_things,
      'notes': notes,
      'hook_number': hook_number,
      'vehicle_type': vehicle_type,
      'driver': driver,
      'location': location,
      'is_parked': is_parked,
      'vehicle_photo': vehicle_photo,
      'thumbnail_photo': thumbnail_photo,
      'searchString': searchString,
      'driver_id': driver_id,
      'location_id': location_id,
      'vehicle_type_id': vehicle_type_id,
      'arrival_time': arrival_time,
      'eta_extend': eta_extend,
      'is_card_based': is_card_based,
      'parked_by': parked_by,
      'parked_by_id': parked_by_id,
      'picked_by': picked_by,
      'picked_by_id': picked_by_id,
      'eta_variable': eta_variable,
      'eta_minutes': eta_minutes,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory GuestRequestData.fromMap(Map<String, dynamic> map) {
    return GuestRequestData(
      transaction_id: map['transaction_id'],
      vehicle_number: map['vehicle_number'],
      guest_name: map['guest_name'],
      guest_mobile: map['guest_mobile'],
      guest_email: map['guest_email'],
      entry_time: map['entry_time'],
      valuable: map['valuable'],
      valuable_things: map['valuable_things'],
      notes: map['notes'],
      hook_number: map['hook_number'],
      vehicle_type: map['vehicle_type'],
      driver: map['driver'],
      location: map['location'],
      is_parked: map['is_parked'],
      vehicle_photo: map['vehicle_photo'] != null
          ? List<String>.from(map['vehicle_photo'])
          : null,
      thumbnail_photo: map['thumbnail_photo'] != null
          ? List<String>.from(map['thumbnail_photo'])
          : null,
      searchString: map['searchString'],
      driver_id: map['driver_id'],
      location_id: map['location_id'],
      vehicle_type_id: map['vehicle_type_id'],
      arrival_time: map['arrival_time'],
      eta_extend: map['eta_extend'],
      is_card_based: map['is_card_based'],
      parked_by: map['parked_by'],
      parked_by_id: map['parked_by_id']?.toInt(),
      picked_by: map['picked_by'],
      picked_by_id: map['picked_by_id']?.toInt(),
      eta_variable: map['eta_variable'] != null
          ? List<String?>.from(map['eta_variable'])
          : null,
      eta_minutes: map['eta_minutes'].toString(),
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GuestRequestData.fromJson(String source) =>
      GuestRequestData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GuestRequestData(transaction_id: $transaction_id, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, guest_email: $guest_email, entry_time: $entry_time, valuable: $valuable, valuable_things: $valuable_things, notes: $notes, hook_number: $hook_number, vehicle_type: $vehicle_type, driver: $driver, location: $location, is_parked: $is_parked, vehicle_photo: $vehicle_photo, thumbnail_photo: $thumbnail_photo, searchString: $searchString, driver_id: $driver_id, location_id: $location_id, vehicle_type_id: $vehicle_type_id, arrival_time: $arrival_time, eta_extend: $eta_extend, is_card_based: $is_card_based, parked_by: $parked_by, parked_by_id: $parked_by_id, picked_by: $picked_by, picked_by_id: $picked_by_id, eta_variable: $eta_variable, eta_minutes: $eta_minutes, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GuestRequestData &&
        other.transaction_id == transaction_id &&
        other.vehicle_number == vehicle_number &&
        other.guest_name == guest_name &&
        other.guest_mobile == guest_mobile &&
        other.guest_email == guest_email &&
        other.entry_time == entry_time &&
        other.valuable == valuable &&
        other.valuable_things == valuable_things &&
        other.notes == notes &&
        other.hook_number == hook_number &&
        other.vehicle_type == vehicle_type &&
        other.driver == driver &&
        other.location == location &&
        other.is_parked == is_parked &&
        listEquals(other.vehicle_photo, vehicle_photo) &&
        listEquals(other.thumbnail_photo, thumbnail_photo) &&
        other.searchString == searchString &&
        other.driver_id == driver_id &&
        other.location_id == location_id &&
        other.vehicle_type_id == vehicle_type_id &&
        other.arrival_time == arrival_time &&
        other.eta_extend == eta_extend &&
        other.is_card_based == is_card_based &&
        other.parked_by == parked_by &&
        other.parked_by_id == parked_by_id &&
        other.picked_by == picked_by &&
        other.picked_by_id == picked_by_id &&
        listEquals(other.eta_variable, eta_variable) &&
        other.eta_minutes == eta_minutes &&
        other.vehicle_name == vehicle_name &&
        other.vehicle_color == vehicle_color &&
        other.slots == slots;
  }

  @override
  int get hashCode {
    return transaction_id.hashCode ^
        vehicle_number.hashCode ^
        guest_name.hashCode ^
        guest_mobile.hashCode ^
        guest_email.hashCode ^
        entry_time.hashCode ^
        valuable.hashCode ^
        valuable_things.hashCode ^
        notes.hashCode ^
        hook_number.hashCode ^
        vehicle_type.hashCode ^
        driver.hashCode ^
        location.hashCode ^
        is_parked.hashCode ^
        vehicle_photo.hashCode ^
        thumbnail_photo.hashCode ^
        searchString.hashCode ^
        driver_id.hashCode ^
        location_id.hashCode ^
        vehicle_type_id.hashCode ^
        arrival_time.hashCode ^
        eta_extend.hashCode ^
        is_card_based.hashCode ^
        parked_by.hashCode ^
        parked_by_id.hashCode ^
        picked_by.hashCode ^
        picked_by_id.hashCode ^
        eta_variable.hashCode ^
        eta_minutes.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }
}
