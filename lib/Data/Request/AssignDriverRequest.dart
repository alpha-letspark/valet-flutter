import 'dart:convert';

class AssignDriverRequest {
  String? transaction_id;
  String? driver_id;
  AssignDriverRequest({
    this.transaction_id,
    this.driver_id,
  });

  AssignDriverRequest copyWith({
    String? transaction_id,
    String? driver_id,
  }) {
    return AssignDriverRequest(
      transaction_id: transaction_id ?? this.transaction_id,
      driver_id: driver_id ?? this.driver_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transaction_id,
      'driver_id': driver_id,
    };
  }

  factory AssignDriverRequest.fromMap(Map<String, dynamic> map) {
    return AssignDriverRequest(
      transaction_id: map['transaction_id'],
      driver_id: map['driver_id'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory AssignDriverRequest.fromJson(String source) =>
      AssignDriverRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AssignDriverRequest(transaction_id: $transaction_id, driver_id: $driver_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssignDriverRequest &&
        other.transaction_id == transaction_id &&
        other.driver_id == driver_id;
  }

  @override
  int get hashCode => transaction_id.hashCode ^ driver_id.hashCode;
}
