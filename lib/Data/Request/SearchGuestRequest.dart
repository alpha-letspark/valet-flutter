import 'dart:convert';

class SearchGuestRequest {
  String? vehicle_number;
  String? client_id;
  SearchGuestRequest({
    this.vehicle_number,
    this.client_id,
  });

  SearchGuestRequest copyWith({
    String? vehicle_number,
    String? client_id,
  }) {
    return SearchGuestRequest(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      client_id: client_id ?? this.client_id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicle_number': vehicle_number,
      'client_id': client_id,
    };
  }

  factory SearchGuestRequest.fromMap(Map<String, dynamic> map) {
    return SearchGuestRequest(
      vehicle_number: map['vehicle_number'],
      client_id: map['client_id'],
    );
  }

  // String toJson() => json.encode(toMap());

  factory SearchGuestRequest.fromJson(String source) =>
      SearchGuestRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'SearchGuestRequest(vehicle_number: $vehicle_number, client_id: $client_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchGuestRequest &&
        other.vehicle_number == vehicle_number &&
        other.client_id == client_id;
  }

  @override
  int get hashCode => vehicle_number.hashCode ^ client_id.hashCode;
}
