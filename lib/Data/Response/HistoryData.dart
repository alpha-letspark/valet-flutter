import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoryData {
  String? transaction_id;
  String? vehicle_number;
  String? guest_name;
  String? guest_mobile;
  String? guest_email;
  String? entry_time;
  String? exit_time;
  String? valuable;
  String? valuable_things;
  String? notes;
  String? hook_number;
  String? vehicle_name;
  String? driver_in;
  String? driver_out;
  String? parked_location;
  List<String?>? vehicle_photo;
  String? searchString;
  String? vehicle_color;
  String? slots;

  HistoryData({
    this.transaction_id,
    this.vehicle_number,
    this.guest_name,
    this.guest_mobile,
    this.guest_email,
    this.entry_time,
    this.exit_time,
    this.valuable,
    this.valuable_things,
    this.notes,
    this.hook_number,
    this.vehicle_name,
    this.driver_in,
    this.driver_out,
    this.parked_location,
    this.vehicle_photo,
    this.searchString,
    this.vehicle_color,
    this.slots,
  });

  HistoryData copyWith({
    String? transaction_id,
    String? vehicle_number,
    String? guest_name,
    String? guest_mobile,
    String? guest_email,
    String? entry_time,
    String? exit_time,
    String? valuable,
    String? valuable_things,
    String? notes,
    String? hook_number,
    String? vehicle_name,
    String? driver_in,
    String? driver_out,
    String? parked_location,
    List<String?>? vehicle_photo,
    String? searchString,
    String? vehicle_color,
    String? slots,
  }) {
    return HistoryData(
      transaction_id: transaction_id ?? this.transaction_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      guest_name: guest_name ?? this.guest_name,
      guest_mobile: guest_mobile ?? this.guest_mobile,
      guest_email: guest_email ?? this.guest_email,
      entry_time: entry_time ?? this.entry_time,
      exit_time: exit_time ?? this.exit_time,
      valuable: valuable ?? this.valuable,
      valuable_things: valuable_things ?? this.valuable_things,
      notes: notes ?? this.notes,
      hook_number: hook_number ?? this.hook_number,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      driver_in: driver_in ?? this.driver_in,
      driver_out: driver_out ?? this.driver_out,
      parked_location: parked_location ?? this.parked_location,
      vehicle_photo: vehicle_photo ?? this.vehicle_photo,
      searchString: searchString ?? this.searchString,
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
      'exit_time': exit_time,
      'valuable': valuable,
      'valuable_things': valuable_things,
      'notes': notes,
      'hook_number': hook_number,
      'vehicle_name': vehicle_name,
      'driver_in': driver_in,
      'driver_out': driver_out,
      'parked_location': parked_location,
      'vehicle_photo': vehicle_photo,
      'searchString': searchString,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory HistoryData.fromMap(Map<String, dynamic> map) {
    return HistoryData(
      transaction_id: map['transaction_id'],
      vehicle_number: map['vehicle_number'],
      guest_name: map['guest_name'],
      guest_mobile: map['guest_mobile'],
      guest_email: map['guest_email'],
      entry_time: map['entry_time'],
      exit_time: map['exit_time'],
      valuable: map['valuable'],
      valuable_things: map['valuable_things'],
      notes: map['notes'],
      hook_number: map['hook_number'],
      vehicle_name: map['vehicle_name'],
      driver_in: map['driver_in'],
      driver_out: map['driver_out'],
      parked_location: map['parked_location'],
      vehicle_photo: map['vehicle_photo'] != null
          ? List<String?>.from(map['vehicle_photo'])
          : null,
      searchString: map['searchString'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryData.fromJson(String source) =>
      HistoryData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HistoryData(transaction_id: $transaction_id, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, guest_email: $guest_email, entry_time: $entry_time, exit_time: $exit_time, valuable: $valuable, valuable_things: $valuable_things, notes: $notes, hook_number: $hook_number, vehicle_name: $vehicle_name, driver_in: $driver_in, driver_out: $driver_out, parked_location: $parked_location, vehicle_photo: $vehicle_photo, searchString: $searchString, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryData &&
        other.transaction_id == transaction_id &&
        other.vehicle_number == vehicle_number &&
        other.guest_name == guest_name &&
        other.guest_mobile == guest_mobile &&
        other.guest_email == guest_email &&
        other.entry_time == entry_time &&
        other.exit_time == exit_time &&
        other.valuable == valuable &&
        other.valuable_things == valuable_things &&
        other.notes == notes &&
        other.hook_number == hook_number &&
        other.vehicle_name == vehicle_name &&
        other.driver_in == driver_in &&
        other.driver_out == driver_out &&
        other.parked_location == parked_location &&
        listEquals(other.vehicle_photo, vehicle_photo) &&
        other.searchString == searchString &&
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
        exit_time.hashCode ^
        valuable.hashCode ^
        valuable_things.hashCode ^
        notes.hashCode ^
        hook_number.hashCode ^
        vehicle_name.hashCode ^
        driver_in.hashCode ^
        driver_out.hashCode ^
        parked_location.hashCode ^
        vehicle_photo.hashCode ^
        searchString.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }

  String? toSearchString() {
    if (searchString == null) {
      StringBuffer search = StringBuffer();
      if (vehicle_name != null && vehicle_name!.isNotEmpty) {
        search.write(vehicle_name);
      }
      if (guest_mobile != null && guest_mobile!.isNotEmpty) {
        search.write(guest_mobile);
      }
      if (vehicle_number != null && vehicle_number!.isNotEmpty) {
        search.write(vehicle_number);
      }

      searchString = search.toString();
      return searchString;
    }
    return searchString;
  }
}
