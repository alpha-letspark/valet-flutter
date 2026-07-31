// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SaveDeviceTokenRequest {
  String? client_id;
  String? user_id;
  String? player_id;
  SaveDeviceTokenRequest({
    this.client_id,
    this.user_id,
    this.player_id,
  });



  SaveDeviceTokenRequest copyWith({
    String? client_id,
    String? user_id,
    String? player_id,
  }) {
    return SaveDeviceTokenRequest(
      client_id: client_id ?? this.client_id,
      user_id: user_id ?? this.user_id,
      player_id: player_id ?? this.player_id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'client_id': client_id,
      'user_id': user_id,
      'player_id': player_id,
    };
  }

  factory SaveDeviceTokenRequest.fromMap(Map<String, dynamic> map) {
    return SaveDeviceTokenRequest(
      client_id: map['client_id'] != null ? map['client_id'] as String : null,
      user_id: map['user_id'] != null ? map['user_id'] as String : null,
      player_id: map['player_id'] != null ? map['player_id'] as String : null,
    );
  }

  //String toJson() => json.encode(toMap());

  factory SaveDeviceTokenRequest.fromJson(String source) => SaveDeviceTokenRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SaveDeviceTokenRequest(client_id: $client_id, user_id: $user_id, player_id: $player_id)';

  @override
  bool operator ==(covariant SaveDeviceTokenRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.client_id == client_id &&
      other.user_id == user_id &&
      other.player_id == player_id;
  }

  @override
  int get hashCode => client_id.hashCode ^ user_id.hashCode ^ player_id.hashCode;
  }
