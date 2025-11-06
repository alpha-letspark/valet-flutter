import 'dart:convert';

class LoginRequest {
  String? username;
  String? password;
  String? player_id;
  LoginRequest({
    this.username,
    this.password,
    this.player_id,
  });

  LoginRequest copyWith({
    String? username,
    String? password,
    String? player_id,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      player_id: player_id ?? this.player_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'player_id': player_id,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'],
      password: map['password'],
      player_id: map['player_id'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'LoginRequest(username: $username, password: $password, player_id: $player_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginRequest &&
        other.username == username &&
        other.password == password &&
        other.player_id == player_id;
  }

  @override
  int get hashCode =>
      username.hashCode ^ password.hashCode ^ player_id.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'player_id': player_id,
    };
  }
}
