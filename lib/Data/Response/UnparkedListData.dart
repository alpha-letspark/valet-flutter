import 'dart:convert';

import 'package:flutter/foundation.dart';

class UnparkedListData {
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
  bool? is_card_based;
  List<String>? vehicle_photo;
  List<String>? thumbnail_photo;
  String? searchString;
  String? driver_id;
  String? location_id;
  String? vehicle_type_id;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  UnparkedListData({
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
    this.is_card_based,
    this.vehicle_photo,
    this.thumbnail_photo,
    this.searchString,
    this.driver_id,
    this.location_id,
    this.vehicle_type_id,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  UnparkedListData copyWith({
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
    bool? is_card_based,
    List<String>? vehicle_photo,
    List<String>? thumbnail_photo,
    String? searchString,
    String? driver_id,
    String? location_id,
    String? vehicle_type_id,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return UnparkedListData(
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
      is_card_based: is_card_based ?? this.is_card_based,
      vehicle_photo: vehicle_photo ?? this.vehicle_photo,
      thumbnail_photo: thumbnail_photo ?? this.thumbnail_photo,
      searchString: searchString ?? this.searchString,
      driver_id: driver_id ?? this.driver_id,
      location_id: location_id ?? this.location_id,
      vehicle_type_id: vehicle_type_id ?? this.vehicle_type_id,
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
      'is_card_based': is_card_based,
      'vehicle_photo': vehicle_photo,
      'thumbnail_photo': thumbnail_photo,
      'searchString': searchString,
      'driver_id': driver_id,
      'location_id': location_id,
      'vehicle_type_id': vehicle_type_id,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory UnparkedListData.fromMap(Map<String, dynamic> map) {
    return UnparkedListData(
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
      is_card_based: map['is_card_based'],
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
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UnparkedListData.fromJson(String source) =>
      UnparkedListData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UnparkedListData(transaction_id: $transaction_id, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, guest_email: $guest_email, entry_time: $entry_time, valuable: $valuable, valuable_things: $valuable_things, notes: $notes, hook_number: $hook_number, vehicle_type: $vehicle_type, driver: $driver, location: $location, is_parked: $is_parked, is_card_based: $is_card_based, vehicle_photo: $vehicle_photo, thumbnail_photo: $thumbnail_photo, searchString: $searchString, driver_id: $driver_id, location_id: $location_id, vehicle_type_id: $vehicle_type_id, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UnparkedListData &&
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
        other.is_card_based == is_card_based &&
        listEquals(other.vehicle_photo, vehicle_photo) &&
        listEquals(other.thumbnail_photo, thumbnail_photo) &&
        other.searchString == searchString &&
        other.driver_id == driver_id &&
        other.location_id == location_id &&
        other.vehicle_type_id == vehicle_type_id &&
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
        is_card_based.hashCode ^
        vehicle_photo.hashCode ^
        thumbnail_photo.hashCode ^
        searchString.hashCode ^
        driver_id.hashCode ^
        location_id.hashCode ^
        vehicle_type_id.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }

  String toSearchString() {
    if (searchString == null) {
      StringBuffer search = StringBuffer();

      if (hook_number != null && hook_number!.isNotEmpty) {
        search.write(hook_number);
      }
      if (vehicle_number != null && vehicle_number!.isNotEmpty) {
        search.write(vehicle_number);
      }

      searchString = search.toString();
      return searchString ?? "";
    }
    return searchString ?? "";
  }
}
