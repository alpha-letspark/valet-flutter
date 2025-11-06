import 'dart:convert';

import 'package:flutter/foundation.dart';

class InputFieldSMSBased {
  List<String?>? sms_input_permission;
  List<String?>? sms_entry_mondatory;
  List<String?>? sms_update_mondatory;
  InputFieldSMSBased({
    this.sms_input_permission,
    this.sms_entry_mondatory,
    this.sms_update_mondatory,
  });

  InputFieldSMSBased copyWith({
    List<String>? sms_input_permission,
    List<String>? sms_entry_mondatory,
    List<String>? sms_update_mondatory,
  }) {
    return InputFieldSMSBased(
      sms_input_permission: sms_input_permission ?? this.sms_input_permission,
      sms_entry_mondatory: sms_entry_mondatory ?? this.sms_entry_mondatory,
      sms_update_mondatory: sms_update_mondatory ?? this.sms_update_mondatory,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sms_input_permission': sms_input_permission,
      'sms_entry_mondatory': sms_entry_mondatory,
      'sms_update_mondatory': sms_update_mondatory,
    };
  }

  factory InputFieldSMSBased.fromMap(Map<String, dynamic> map) {
    return InputFieldSMSBased(
      sms_input_permission: List<String?>.from(map['sms_input_permission']),
      sms_entry_mondatory: List<String?>.from(map['sms_entry_mondatory']),
      sms_update_mondatory: List<String?>.from(map['sms_update_mondatory']),
    );
  }

  String toJson() => json.encode(toMap());

  factory InputFieldSMSBased.fromJson(String source) =>
      InputFieldSMSBased.fromMap(json.decode(source));

  @override
  String toString() =>
      'InputFieldSMSBased(sms_input_permission: $sms_input_permission, sms_entry_mondatory: $sms_entry_mondatory, sms_update_mondatory: $sms_update_mondatory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputFieldSMSBased &&
        listEquals(other.sms_input_permission, sms_input_permission) &&
        listEquals(other.sms_entry_mondatory, sms_entry_mondatory) &&
        listEquals(other.sms_update_mondatory, sms_update_mondatory);
  }

  @override
  int get hashCode =>
      sms_input_permission.hashCode ^
      sms_entry_mondatory.hashCode ^
      sms_update_mondatory.hashCode;
}
