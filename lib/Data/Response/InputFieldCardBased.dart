import 'dart:convert';

import 'package:flutter/foundation.dart';

class InputFieldCardBased {
  List<String?>? card_input_permission;
  List<String?>? card_entry_mondatory;
  List<String?>? card_update_mondatory;
  InputFieldCardBased({
    this.card_input_permission,
    this.card_entry_mondatory,
    this.card_update_mondatory,
  });

  InputFieldCardBased copyWith({
    List<String?>? card_input_permission,
    List<String?>? card_entry_mondatory,
    List<String?>? card_update_mondatory,
  }) {
    return InputFieldCardBased(
      card_input_permission:
          card_input_permission ?? this.card_input_permission,
      card_entry_mondatory: card_entry_mondatory ?? this.card_entry_mondatory,
      card_update_mondatory:
          card_update_mondatory ?? this.card_update_mondatory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'card_input_permission': card_input_permission,
      'card_entry_mondatory': card_entry_mondatory,
      'card_update_mondatory': card_update_mondatory,
    };
  }

  factory InputFieldCardBased.fromMap(Map<String, dynamic> map) {
    return InputFieldCardBased(
      card_input_permission: map['card_input_permission'] != null
          ? List<String?>.from(map['card_input_permission'])
          : [],
      card_entry_mondatory: map['card_entry_mondatory'] != null
          ? List<String?>.from(map['card_entry_mondatory'])
          : [],
      card_update_mondatory: map['card_update_mondatory'] != null
          ? List<String?>.from(map['card_update_mondatory'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory InputFieldCardBased.fromJson(String source) =>
      InputFieldCardBased.fromMap(json.decode(source));

  @override
  String toString() =>
      'InputFieldCardBased(card_input_permission: $card_input_permission, card_entry_mondatory: $card_entry_mondatory, card_update_mondatory: $card_update_mondatory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputFieldCardBased &&
        listEquals(other.card_input_permission, card_input_permission) &&
        listEquals(other.card_entry_mondatory, card_entry_mondatory) &&
        listEquals(other.card_update_mondatory, card_update_mondatory);
  }

  @override
  int get hashCode =>
      card_input_permission.hashCode ^
      card_entry_mondatory.hashCode ^
      card_update_mondatory.hashCode;
}
