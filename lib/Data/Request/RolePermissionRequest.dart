import 'dart:convert';

class RolePermissionRequest {
  String? client_id;
  String? user_id;
  RolePermissionRequest({
    this.client_id,
    this.user_id,
  });

  RolePermissionRequest copyWith({
    String? client_id,
    String? user_id,
  }) {
    return RolePermissionRequest(
      client_id: client_id ?? this.client_id,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'user_id': user_id,
    };
  }

  factory RolePermissionRequest.fromMap(Map<String, dynamic> map) {
    return RolePermissionRequest(
      client_id: map['client_id'],
      user_id: map['user_id'],
    );
  }

  factory RolePermissionRequest.fromJson(String source) =>
      RolePermissionRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'RolePermissionRequest(client_id: $client_id, user_id: $user_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RolePermissionRequest &&
        other.client_id == client_id &&
        other.user_id == user_id;
  }

  @override
  int get hashCode => client_id.hashCode ^ user_id.hashCode;
}
