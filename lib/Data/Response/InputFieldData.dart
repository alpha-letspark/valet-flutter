import 'dart:convert';

import 'package:valet_app/Data/Response/InputFieldCardBased.dart';
import 'package:valet_app/Data/Response/InputFieldFormPermission.dart';
import 'package:valet_app/Data/Response/InputFieldSMSBased.dart';

class InputFieldData {
  InputFieldFormPermission? form_permission;
  InputFieldSMSBased? sms_based;
  InputFieldCardBased? card_based;
  InputFieldData({
    this.form_permission,
    this.sms_based,
    this.card_based,
  });

  InputFieldData copyWith({
    InputFieldFormPermission? form_permission,
    InputFieldSMSBased? sms_based,
    InputFieldCardBased? card_based,
  }) {
    return InputFieldData(
      form_permission: form_permission ?? this.form_permission,
      sms_based: sms_based ?? this.sms_based,
      card_based: card_based ?? this.card_based,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'form_permission': form_permission?.toMap(),
      'sms_based': sms_based?.toMap(),
      'card_based': card_based?.toMap(),
    };
  }

  factory InputFieldData.fromMap(Map<String, dynamic> map) {
    return InputFieldData(
      form_permission: map['form_permission'] != null
          ? InputFieldFormPermission.fromMap(map['form_permission'])
          : null,
      sms_based: map['sms_based'] != null
          ? InputFieldSMSBased.fromMap(map['sms_based'])
          : null,
      card_based: map['card_based'] != null
          ? InputFieldCardBased.fromMap(map['card_based'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InputFieldData.fromJson(String source) =>
      InputFieldData.fromMap(json.decode(source));

  @override
  String toString() =>
      'InputFieldData(form_permission: $form_permission, sms_based: $sms_based, card_based: $card_based)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputFieldData &&
        other.form_permission == form_permission &&
        other.sms_based == sms_based &&
        other.card_based == card_based;
  }

  @override
  int get hashCode =>
      form_permission.hashCode ^ sms_based.hashCode ^ card_based.hashCode;
}
