import 'dart:convert';

import 'package:flutter/foundation.dart';

class ParkingDetailsData {
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
  String? sms_status;
  List<String>? vehicle_photo;
  List<String>? thumbnail_photo;
  String? vehicle_name;
  String? vehicle_color;
  String? slots;

  ParkingDetailsData({
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
    this.sms_status,
    this.vehicle_photo,
    this.thumbnail_photo,
    this.vehicle_name,
    this.vehicle_color,
    this.slots,
  });

  ParkingDetailsData copyWith({
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
    String? sms_status,
    List<String>? vehicle_photo,
    List<String>? thumbnail_photo,
    String? vehicle_name,
    String? vehicle_color,
    String? slots,
  }) {
    return ParkingDetailsData(
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
      sms_status: sms_status ?? this.sms_status,
      vehicle_photo: vehicle_photo ?? this.vehicle_photo,
      thumbnail_photo: thumbnail_photo ?? this.thumbnail_photo,
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
      'sms_status': sms_status,
      'vehicle_photo': vehicle_photo,
      'thumbnail_photo': thumbnail_photo,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'slots': slots,
    };
  }

  factory ParkingDetailsData.fromMap(Map<String, dynamic> map) {
    return ParkingDetailsData(
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
      sms_status: map['sms_status'],
      vehicle_photo: map['vehicle_photo'] == null
          ? []
          : List<String>.from(map['vehicle_photo']),
      thumbnail_photo: map['thumbnail_photo'] == null
          ? []
          : List<String>.from(map['thumbnail_photo']),
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      slots: map['slots'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingDetailsData.fromJson(String source) =>
      ParkingDetailsData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParkingDetailsData(transaction_id: $transaction_id, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, guest_email: $guest_email, entry_time: $entry_time, valuable: $valuable, valuable_things: $valuable_things, notes: $notes, hook_number: $hook_number, vehicle_type: $vehicle_type, driver: $driver, location: $location, sms_status: $sms_status, vehicle_photo: $vehicle_photo, thumbnail_photo: $thumbnail_photo, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, slots: $slots)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingDetailsData &&
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
        other.sms_status == sms_status &&
        listEquals(other.vehicle_photo, vehicle_photo) &&
        listEquals(other.thumbnail_photo, thumbnail_photo) &&
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
        sms_status.hashCode ^
        vehicle_photo.hashCode ^
        thumbnail_photo.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        slots.hashCode;
  }
}
