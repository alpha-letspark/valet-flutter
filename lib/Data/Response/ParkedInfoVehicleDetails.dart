import 'dart:convert';

class ParkedInfoDataVehicleDetails {
  String? vehicle_number;
  String? transaction_id;
  String? hook_number;
  String? searchString;

  ParkedInfoDataVehicleDetails({
    this.vehicle_number,
    this.transaction_id,
    this.hook_number,
    this.searchString,
  });

  ParkedInfoDataVehicleDetails copyWith({
    String? vehicle_number,
    String? transaction_id,
    String? hook_number,
    String? searchString,
  }) {
    return ParkedInfoDataVehicleDetails(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      transaction_id: transaction_id ?? this.transaction_id,
      hook_number: hook_number ?? this.hook_number,
      searchString: searchString ?? this.searchString,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicle_number': vehicle_number,
      'transaction_id': transaction_id,
      'hook_number': hook_number,
      'searchString': searchString,
    };
  }

  factory ParkedInfoDataVehicleDetails.fromMap(Map<String, dynamic> map) {
    return ParkedInfoDataVehicleDetails(
      vehicle_number: map['vehicle_number'],
      transaction_id: map['transaction_id'],
      hook_number: map['hook_number'],
      searchString: map['searchString'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkedInfoDataVehicleDetails.fromJson(String source) =>
      ParkedInfoDataVehicleDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParkedInfoDataVehicleDetails(vehicle_number: $vehicle_number, transaction_id: $transaction_id, hook_number: $hook_number, searchString: $searchString)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkedInfoDataVehicleDetails &&
        other.vehicle_number == vehicle_number &&
        other.transaction_id == transaction_id &&
        other.hook_number == hook_number &&
        other.searchString == searchString;
  }

  @override
  int get hashCode {
    return vehicle_number.hashCode ^
        transaction_id.hashCode ^
        hook_number.hashCode ^
        searchString.hashCode;
  }

  String toSearchString() {
    if (searchString == null) {
      StringBuffer search = StringBuffer();

      if (hook_number != null && hook_number!.isNotEmpty) {
        search.write(hook_number);
      }
      if (vehicle_number != null && vehicle_number!.isNotEmpty) {
        search.write(vehicle_number);
      }

      searchString = search.toString();
      return searchString ?? "";
    }
    return searchString ?? "";
  }
}
