import 'dart:convert';

class HistoryCountRequest {
  String? client_id;
  HistoryCountRequest({
    this.client_id,
  });

  HistoryCountRequest copyWith({
    String? client_id,
  }) {
    return HistoryCountRequest(
      client_id: client_id ?? this.client_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': client_id,
    };
  }

  factory HistoryCountRequest.fromMap(Map<String, dynamic> map) {
    return HistoryCountRequest(
      client_id: map['client_id'],
    );
  }

  //String toJson() => json.encode(toMap());

  factory HistoryCountRequest.fromJson(String source) =>
      HistoryCountRequest.fromMap(json.decode(source));

  @override
  String toString() => 'HistoryCountRequest(client_id: $client_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryCountRequest && other.client_id == client_id;
  }

  @override
  int get hashCode => client_id.hashCode;
}
