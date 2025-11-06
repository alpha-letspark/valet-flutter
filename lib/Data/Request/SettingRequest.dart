import 'dart:convert';

class SettingRequest {
  String? client_id;
  int? guest_req;
  int? eta_extend;
  int? eta;
  int? search_suggest;
  SettingRequest({
    this.client_id,
    this.guest_req,
    this.eta_extend,
    this.eta,
    this.search_suggest,
  });

  SettingRequest copyWith({
    String? client_id,
    int? guest_req,
    int? eta_extend,
    int? eta,
    int? search_suggest,
  }) {
    return SettingRequest(
      client_id: client_id ?? this.client_id,
      guest_req: guest_req ?? this.guest_req,
      eta_extend: eta_extend ?? this.eta_extend,
      eta: eta ?? this.eta,
      search_suggest: search_suggest ?? this.search_suggest,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id ?? "0",
      'guest_req': guest_req ?? 0,
      'eta_extend': eta_extend ?? 0,
      'eta': eta ?? 0,
      'search_suggest': search_suggest ?? 0,
    };
  }

  factory SettingRequest.fromMap(Map<String, dynamic> map) {
    return SettingRequest(
      client_id: map['client_id'],
      guest_req: map['guest_req']?.toInt(),
      eta_extend: map['eta_extend']?.toInt(),
      eta: map['eta']?.toInt(),
      search_suggest: map['search_suggest']?.toInt(),
    );
  }

  factory SettingRequest.fromJson(String source) =>
      SettingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingRequest(client_id: $client_id, guest_req: $guest_req, eta_extend: $eta_extend, eta: $eta, search_suggest: $search_suggest)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingRequest &&
        other.client_id == client_id &&
        other.guest_req == guest_req &&
        other.eta_extend == eta_extend &&
        other.eta == eta &&
        other.search_suggest == search_suggest;
  }

  @override
  int get hashCode {
    return client_id.hashCode ^
        guest_req.hashCode ^
        eta_extend.hashCode ^
        eta.hashCode ^
        search_suggest.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'client_id': client_id,
      'guest_req': guest_req,
      'eta_extend': eta_extend,
      'eta': eta,
      'search_suggest': search_suggest,
    };
  }
}
