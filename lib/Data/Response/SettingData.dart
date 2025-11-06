import 'dart:convert';

class SettingData {
  int? guest_req;
  int? eta_extend;
  int? eta;
  int? search_suggest;
  SettingData({
    this.guest_req,
    this.eta_extend,
    this.eta,
    this.search_suggest,
  });

  SettingData copyWith({
    int? guest_req,
    int? eta_extend,
    int? eta,
    int? search_suggest,
  }) {
    return SettingData(
      guest_req: guest_req ?? this.guest_req,
      eta_extend: eta_extend ?? this.eta_extend,
      eta: eta ?? this.eta,
      search_suggest: search_suggest ?? this.search_suggest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'guest_req': guest_req,
      'eta_extend': eta_extend,
      'eta': eta,
      'search_suggest': search_suggest,
    };
  }

  factory SettingData.fromMap(Map<String, dynamic> map) {
    return SettingData(
      guest_req: map['guest_req']?.toInt(),
      eta_extend: map['eta_extend']?.toInt(),
      eta: map['eta']?.toInt(),
      search_suggest: map['search_suggest']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingData.fromJson(String source) =>
      SettingData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingData(guest_req: $guest_req, eta_extend: $eta_extend, eta: $eta, search_suggest: $search_suggest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingData &&
        other.guest_req == guest_req &&
        other.eta_extend == eta_extend &&
        other.eta == eta &&
        other.search_suggest == search_suggest;
  }

  @override
  int get hashCode {
    return guest_req.hashCode ^
        eta_extend.hashCode ^
        eta.hashCode ^
        search_suggest.hashCode;
  }
}
