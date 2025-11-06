import 'dart:convert';

import 'package:flutter/foundation.dart';

class SummaryData {
  int? id;
  String? entry_time;
  String? transaction_id;
  String? vehicle_number;
  String? guest_name;
  String? guest_mobile;
  String? hook_number;
  String? valuable;
  String? valuable_things;
  String? status;
  String? arrival_time;
  String? pickup_by;
  String? accept_user_id;
  String? driver;
  String? parking_name;
  String? eta;
  String? valet_name;
  String? pickuped_by;
  String? vehicle_type;
  String? vehicle_name;
  String? vehicle_color;
  String? parked_by;
  String? notes;
  String? location;
  String? slots;
  List<String>? vehicle_photo;
  List<String>? thumbnail_photo;
  bool? is_card_based;

  SummaryData({
    this.id,
    this.entry_time,
    this.transaction_id,
    this.vehicle_number,
    this.guest_name,
    this.guest_mobile,
    this.hook_number,
    this.valuable,
    this.valuable_things,
    this.status,
    this.arrival_time,
    this.pickup_by,
    this.accept_user_id,
    this.driver,
    this.parking_name,
    this.eta,
    this.valet_name,
    this.pickuped_by,
    this.vehicle_type,
    this.vehicle_name,
    this.vehicle_color,
    this.parked_by,
    this.notes,
    this.location,
    this.slots,
    this.vehicle_photo,
    this.thumbnail_photo,
    this.is_card_based,
  });

  SummaryData copyWith({
    int? id,
    String? entry_time,
    String? transaction_id,
    String? vehicle_number,
    String? guest_name,
    String? guest_mobile,
    String? hook_number,
    String? valuable,
    String? valuable_things,
    String? status,
    String? arrival_time,
    String? pickup_by,
    String? accept_user_id,
    String? driver,
    String? parking_name,
    String? eta,
    String? valet_name,
    String? pickuped_by,
    String? vehicle_type,
    String? vehicle_name,
    String? vehicle_color,
    String? parked_by,
    String? notes,
    String? location,
    String? slots,
    List<String>? vehicle_photo,
    List<String>? thumbnail_photo,
    bool? is_card_based,
  }) {
    return SummaryData(
      id: id ?? this.id,
      entry_time: entry_time ?? this.entry_time,
      transaction_id: transaction_id ?? this.transaction_id,
      vehicle_number: vehicle_number ?? this.vehicle_number,
      guest_name: guest_name ?? this.guest_name,
      guest_mobile: guest_mobile ?? this.guest_mobile,
      hook_number: hook_number ?? this.hook_number,
      valuable: valuable ?? this.valuable,
      valuable_things: valuable_things ?? this.valuable_things,
      status: status ?? this.status,
      arrival_time: arrival_time ?? this.arrival_time,
      pickup_by: pickup_by ?? this.pickup_by,
      accept_user_id: accept_user_id ?? this.accept_user_id,
      driver: driver ?? this.driver,
      parking_name: parking_name ?? this.parking_name,
      eta: eta ?? this.eta,
      valet_name: valet_name ?? this.valet_name,
      pickuped_by: pickuped_by ?? this.pickuped_by,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      vehicle_name: vehicle_name ?? this.vehicle_name,
      vehicle_color: vehicle_color ?? this.vehicle_color,
      parked_by: parked_by ?? this.parked_by,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      slots: slots ?? this.slots,
      vehicle_photo: vehicle_photo ?? this.vehicle_photo,
      thumbnail_photo: thumbnail_photo ?? this.thumbnail_photo,
      is_card_based: is_card_based ?? this.is_card_based,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entry_time': entry_time,
      'transaction_id': transaction_id,
      'vehicle_number': vehicle_number,
      'guest_name': guest_name,
      'guest_mobile': guest_mobile,
      'hook_number': hook_number,
      'valuable': valuable,
      'valuable_things': valuable_things,
      'status': status,
      'arrival_time': arrival_time,
      'pickup_by': pickup_by,
      'accept_user_id': accept_user_id,
      'driver': driver,
      'parking_name': parking_name,
      'eta': eta,
      'valet_name': valet_name,
      'pickuped_by': pickuped_by,
      'vehicle_type': vehicle_type,
      'vehicle_name': vehicle_name,
      'vehicle_color': vehicle_color,
      'parked_by': parked_by,
      'notes': notes,
      'location': location,
      'slots': slots,
      'vehicle_photo': vehicle_photo,
      'thumbnail_photo': thumbnail_photo,
      'is_card_based': is_card_based,
    };
  }

  factory SummaryData.fromMap(Map<String, dynamic> map) {
    return SummaryData(
      id: map['id']?.toInt(),
      entry_time: map['entry_time'],
      transaction_id: map['transaction_id'],
      vehicle_number: map['vehicle_number'],
      guest_name: map['guest_name'],
      guest_mobile: map['guest_mobile'],
      hook_number: map['hook_number'],
      valuable: map['valuable'],
      valuable_things: map['valuable_things'],
      status: map['status'],
      arrival_time: map['arrival_time'],
      pickup_by: map['pickup_by'],
      accept_user_id: map['accept_user_id'],
      driver: map['driver'],
      parking_name: map['parking_name'],
      eta: map['eta'],
      valet_name: map['valet_name'],
      pickuped_by: map['pickuped_by'],
      vehicle_type: map['vehicle_type'],
      vehicle_name: map['vehicle_name'],
      vehicle_color: map['vehicle_color'],
      parked_by: map['parked_by'],
      notes: map['notes'],
      location: map['location'],
      slots: map['slots'],
      vehicle_photo: map['vehicle_photo'] == null
          ? []
          : List<String>.from(map['vehicle_photo']),
      thumbnail_photo: map['thumbnail_photo'] == null
          ? []
          : List<String>.from(map['thumbnail_photo']),
      is_card_based: map['is_card_based'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryData.fromJson(String source) =>
      SummaryData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SummaryData(id: $id, entry_time: $entry_time, transaction_id: $transaction_id, vehicle_number: $vehicle_number, guest_name: $guest_name, guest_mobile: $guest_mobile, hook_number: $hook_number, valuable: $valuable, valuable_things: $valuable_things, status: $status, arrival_time: $arrival_time, pickup_by: $pickup_by, accept_user_id: $accept_user_id, driver: $driver, parking_name: $parking_name, eta: $eta, valet_name: $valet_name, pickuped_by: $pickuped_by, vehicle_type: $vehicle_type, vehicle_name: $vehicle_name, vehicle_color: $vehicle_color, parked_by: $parked_by, notes: $notes, location: $location, slots: $slots, vehicle_photo: $vehicle_photo, thumbnail_photo: $thumbnail_photo, is_card_based: $is_card_based)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SummaryData &&
        other.id == id &&
        other.entry_time == entry_time &&
        other.transaction_id == transaction_id &&
        other.vehicle_number == vehicle_number &&
        other.guest_name == guest_name &&
        other.guest_mobile == guest_mobile &&
        other.hook_number == hook_number &&
        other.valuable == valuable &&
        other.valuable_things == valuable_things &&
        other.status == status &&
        other.arrival_time == arrival_time &&
        other.pickup_by == pickup_by &&
        other.accept_user_id == accept_user_id &&
        other.driver == driver &&
        other.parking_name == parking_name &&
        other.eta == eta &&
        other.valet_name == valet_name &&
        other.pickuped_by == pickuped_by &&
        other.vehicle_type == vehicle_type &&
        other.vehicle_name == vehicle_name &&
        other.vehicle_color == vehicle_color &&
        other.parked_by == parked_by &&
        other.notes == notes &&
        other.location == location &&
        other.slots == slots &&
        listEquals(other.vehicle_photo, vehicle_photo) &&
        listEquals(other.thumbnail_photo, thumbnail_photo) &&
        other.is_card_based == is_card_based;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        entry_time.hashCode ^
        transaction_id.hashCode ^
        vehicle_number.hashCode ^
        guest_name.hashCode ^
        guest_mobile.hashCode ^
        hook_number.hashCode ^
        valuable.hashCode ^
        valuable_things.hashCode ^
        status.hashCode ^
        arrival_time.hashCode ^
        pickup_by.hashCode ^
        accept_user_id.hashCode ^
        driver.hashCode ^
        parking_name.hashCode ^
        eta.hashCode ^
        valet_name.hashCode ^
        pickuped_by.hashCode ^
        vehicle_type.hashCode ^
        vehicle_name.hashCode ^
        vehicle_color.hashCode ^
        parked_by.hashCode ^
        notes.hashCode ^
        location.hashCode ^
        slots.hashCode ^
        vehicle_photo.hashCode ^
        thumbnail_photo.hashCode ^
        is_card_based.hashCode;
  }
}
