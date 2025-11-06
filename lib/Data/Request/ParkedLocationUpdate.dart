import 'dart:convert';

class ParkedLocationUpdate {
  String? transaction_id;
  String? location;
  ParkedLocationUpdate({
    this.transaction_id,
    this.location,
  });

  ParkedLocationUpdate copyWith({
    String? transaction_id,
    String? location,
  }) {
    return ParkedLocationUpdate(
      transaction_id: transaction_id ?? this.transaction_id,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transaction_id,
      'location': location,
    };
  }

  factory ParkedLocationUpdate.fromMap(Map<String, dynamic> map) {
    return ParkedLocationUpdate(
      transaction_id: map['transaction_id'],
      location: map['location'],
    );
  }

  factory ParkedLocationUpdate.fromJson(String source) =>
      ParkedLocationUpdate.fromMap(json.decode(source));

  @override
  String toString() =>
      'ParkedLocationUpdate(transaction_id: $transaction_id, location: $location)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkedLocationUpdate &&
        other.transaction_id == transaction_id &&
        other.location == location;
  }

  @override
  int get hashCode => transaction_id.hashCode ^ location.hashCode;
}
