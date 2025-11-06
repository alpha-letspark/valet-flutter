import 'dart:convert';

class CheckHookNumberRequest {
  String? client_id;
  String? hook_number;
  CheckHookNumberRequest({
    this.client_id,
    this.hook_number,
  });

  CheckHookNumberRequest copyWith({
    String? client_id,
    String? hook_number,
  }) {
    return CheckHookNumberRequest(
      client_id: client_id ?? this.client_id,
      hook_number: hook_number ?? this.hook_number,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
      'hook_number': hook_number,
    };
  }

  factory CheckHookNumberRequest.fromMap(Map<String, dynamic> map) {
    return CheckHookNumberRequest(
      client_id: map['client_id'],
      hook_number: map['hook_number'],
    );
  }

  // String toJson() => json.encode(toMap());

  factory CheckHookNumberRequest.fromJson(String source) =>
      CheckHookNumberRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'CheckHookNumberRequest(client_id: $client_id, hook_number: $hook_number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckHookNumberRequest &&
        other.client_id == client_id &&
        other.hook_number == hook_number;
  }

  @override
  int get hashCode => client_id.hashCode ^ hook_number.hashCode;
}
