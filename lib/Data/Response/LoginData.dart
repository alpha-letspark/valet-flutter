import 'dart:convert';

class LoginData {
  int? id;
  String? client_id;
  String? name;
  String? lname;
  String? username;
  String? status;
  String? login_session;
  String? client_role_id;
  String? role_name;
  String? client_name;
  String? client_logo;
  String? masterkey;

  LoginData({
    this.id,
    this.client_id,
    this.name,
    this.lname,
    this.username,
    this.status,
    this.login_session,
    this.client_role_id,
    this.role_name,
    this.client_name,
    this.client_logo,
    this.masterkey,
  });

  LoginData copyWith({
    int? id,
    String? client_id,
    String? name,
    String? lname,
    String? username,
    String? status,
    String? login_session,
    String? client_role_id,
    String? role_name,
    String? client_name,
    String? client_logo,
    String? masterkey,
  }) {
    return LoginData(
      id: id ?? this.id,
      client_id: client_id ?? this.client_id,
      name: name ?? this.name,
      lname: lname ?? this.lname,
      username: username ?? this.username,
      status: status ?? this.status,
      login_session: login_session ?? this.login_session,
      client_role_id: client_role_id ?? this.client_role_id,
      role_name: role_name ?? this.role_name,
      client_name: client_name ?? this.client_name,
      client_logo: client_logo ?? this.client_logo,
      masterkey: masterkey ?? this.masterkey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_id': client_id,
      'name': name,
      'lname': lname,
      'username': username,
      'status': status,
      'login_session': login_session,
      'client_role_id': client_role_id,
      'role_name': role_name,
      'client_name': client_name,
      'client_logo': client_logo,
      'masterkey': masterkey,
    };
  }

  factory LoginData.fromMap(Map<String, dynamic> map) {
    return LoginData(
      id: map['id']?.toInt(),
      client_id: map['client_id'],
      name: map['name'],
      lname: map['lname'],
      username: map['username'],
      status: map['status'],
      login_session: map['login_session'],
      client_role_id: map['client_role_id'],
      role_name: map['role_name'],
      client_name: map['client_name'],
      client_logo: map['client_logo'],
      masterkey: map['masterkey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginData.fromJson(String source) =>
      LoginData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginData(id: $id, client_id: $client_id, name: $name, lname: $lname, username: $username, status: $status, login_session: $login_session, client_role_id: $client_role_id, role_name: $role_name, client_name: $client_name, client_logo: $client_logo, masterkey: $masterkey)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginData &&
        other.id == id &&
        other.client_id == client_id &&
        other.name == name &&
        other.lname == lname &&
        other.username == username &&
        other.status == status &&
        other.login_session == login_session &&
        other.client_role_id == client_role_id &&
        other.role_name == role_name &&
        other.client_name == client_name &&
        other.client_logo == client_logo &&
        other.masterkey == masterkey;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        client_id.hashCode ^
        name.hashCode ^
        lname.hashCode ^
        username.hashCode ^
        status.hashCode ^
        login_session.hashCode ^
        client_role_id.hashCode ^
        role_name.hashCode ^
        client_name.hashCode ^
        client_logo.hashCode ^
        masterkey.hashCode;
  }
}
