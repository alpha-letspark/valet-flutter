import 'dart:convert';

class InputFieldFormPermission {
  bool? sms_based;
  bool? card_based;
  bool? hybrid;
  InputFieldFormPermission({
    this.sms_based,
    this.card_based,
    this.hybrid,
  });

  InputFieldFormPermission copyWith({
    bool? sms_based,
    bool? card_based,
    bool? hybrid,
  }) {
    return InputFieldFormPermission(
      sms_based: sms_based ?? this.sms_based,
      card_based: card_based ?? this.card_based,
      hybrid: hybrid ?? this.hybrid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sms_based': sms_based,
      'card_based': card_based,
      'hybrid': hybrid,
    };
  }

  factory InputFieldFormPermission.fromMap(Map<String, dynamic> map) {
    return InputFieldFormPermission(
      sms_based: map['sms_based'],
      card_based: map['card_based'],
      hybrid: map['hybrid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InputFieldFormPermission.fromJson(String source) =>
      InputFieldFormPermission.fromMap(json.decode(source));

  @override
  String toString() =>
      'InputFieldFormPermission(sms_based: $sms_based, card_based: $card_based, hybrid: $hybrid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputFieldFormPermission &&
        other.sms_based == sms_based &&
        other.card_based == card_based &&
        other.hybrid == hybrid;
  }

  @override
  int get hashCode =>
      sms_based.hashCode ^ card_based.hashCode ^ hybrid.hashCode;
}
