import 'dart:convert';

class AccpetGuestRequest {
  String? accept_user_id;
  String? transaction_id;
  String? eta_minutes;
  AccpetGuestRequest({
    this.accept_user_id,
    this.transaction_id,
    this.eta_minutes,
  });

  AccpetGuestRequest copyWith({
    String? accept_user_id,
    String? transaction_id,
    String? eta_minutes,
  }) {
    return AccpetGuestRequest(
      accept_user_id: accept_user_id ?? this.accept_user_id,
      transaction_id: transaction_id ?? this.transaction_id,
      eta_minutes: eta_minutes ?? this.eta_minutes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accept_user_id': accept_user_id,
      'transaction_id': transaction_id,
      'eta_minutes': eta_minutes,
    };
  }

  factory AccpetGuestRequest.fromMap(Map<String, dynamic> map) {
    return AccpetGuestRequest(
      accept_user_id: map['accept_user_id'],
      transaction_id: map['transaction_id'],
      eta_minutes: map['eta_minutes'],
    );
  }

  factory AccpetGuestRequest.fromJson(String source) =>
      AccpetGuestRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AccpetGuestRequest(accept_user_id: $accept_user_id, transaction_id: $transaction_id, eta_minutes: $eta_minutes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccpetGuestRequest &&
        other.accept_user_id == accept_user_id &&
        other.transaction_id == transaction_id &&
        other.eta_minutes == eta_minutes;
  }

  @override
  int get hashCode =>
      accept_user_id.hashCode ^ transaction_id.hashCode ^ eta_minutes.hashCode;
}
