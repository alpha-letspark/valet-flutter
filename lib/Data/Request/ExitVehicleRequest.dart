import 'dart:convert';

class ExitVehicleRequest {
  String? exit_user_id;
  String? client_id;
  String? transaction_id;
  String? password;
  String? pin;
  ExitVehicleRequest({
    this.exit_user_id,
    this.client_id,
    this.transaction_id,
    this.password,
    this.pin,
  });

  ExitVehicleRequest copyWith({
    String? exit_user_id,
    String? client_id,
    String? transaction_id,
    String? password,
    String? pin,
  }) {
    return ExitVehicleRequest(
      exit_user_id: exit_user_id ?? this.exit_user_id,
      client_id: client_id ?? this.client_id,
      transaction_id: transaction_id ?? this.transaction_id,
      password: password ?? this.password,
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exit_user_id': exit_user_id,
      'client_id': client_id,
      'transaction_id': transaction_id,
      'password': password,
      'pin': pin,
    };
  }

  factory ExitVehicleRequest.fromMap(Map<String, dynamic> map) {
    return ExitVehicleRequest(
      exit_user_id: map['exit_user_id'],
      client_id: map['client_id'],
      transaction_id: map['transaction_id'],
      password: map['password'],
      pin: map['pin'],
    );
  }

  factory ExitVehicleRequest.fromJson(String source) =>
      ExitVehicleRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExitVehicleRequest(exit_user_id: $exit_user_id, client_id: $client_id, transaction_id: $transaction_id, password: $password, pin: $pin)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExitVehicleRequest &&
        other.exit_user_id == exit_user_id &&
        other.client_id == client_id &&
        other.transaction_id == transaction_id &&
        other.password == password &&
        other.pin == pin;
  }

  @override
  int get hashCode {
    return exit_user_id.hashCode ^
        client_id.hashCode ^
        transaction_id.hashCode ^
        password.hashCode ^
        pin.hashCode;
  }
}
