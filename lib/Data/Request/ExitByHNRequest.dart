import 'dart:convert';

class ExitByHNRequest {
  String? client_id;
  String? transaction_id;
  String? exit_user_id;
  ExitByHNRequest({
    this.client_id,
    this.transaction_id,
    this.exit_user_id,
  });

  ExitByHNRequest copyWith({
    String? client_id,
    String? transaction_id,
    String? exit_user_id,
  }) {
    return ExitByHNRequest(
      client_id: client_id ?? this.client_id,
      transaction_id: transaction_id ?? this.transaction_id,
      exit_user_id: exit_user_id ?? this.exit_user_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'transaction_id': transaction_id,
      'exit_user_id': exit_user_id,
    };
  }

  factory ExitByHNRequest.fromMap(Map<String, dynamic> map) {
    return ExitByHNRequest(
      client_id: map['client_id'],
      transaction_id: map['transaction_id'],
      exit_user_id: map['exit_user_id'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory ExitByHNRequest.fromJson(String source) =>
      ExitByHNRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExitByHNRequest(client_id: $client_id, transaction_id: $transaction_id, exit_user_id: $exit_user_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitByHNRequest &&
        other.client_id == client_id &&
        other.transaction_id == transaction_id &&
        other.exit_user_id == exit_user_id;
  }

  @override
  int get hashCode =>
      client_id.hashCode ^ transaction_id.hashCode ^ exit_user_id.hashCode;
}
