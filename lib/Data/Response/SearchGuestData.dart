import 'dart:convert';

class SearchGuestData {
  String? vehicle_number;
  String? customer_name;
  String? mobile_number;
  String? vehicle_type;
  String? display_string;

  SearchGuestData({
    this.vehicle_number,
    this.customer_name,
    this.mobile_number,
    this.vehicle_type,
    this.display_string,
  });

  SearchGuestData copyWith({
    String? vehicle_number,
    String? customer_name,
    String? mobile_number,
    String? vehicle_type,
    String? display_string,
  }) {
    return SearchGuestData(
      vehicle_number: vehicle_number ?? this.vehicle_number,
      customer_name: customer_name ?? this.customer_name,
      mobile_number: mobile_number ?? this.mobile_number,
      vehicle_type: vehicle_type ?? this.vehicle_type,
      display_string: display_string ?? this.display_string,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicle_number': vehicle_number,
      'customer_name': customer_name,
      'mobile_number': mobile_number,
      'vehicle_type': vehicle_type,
      'display_string': display_string,
    };
  }

  factory SearchGuestData.fromMap(Map<String, dynamic> map) {
    return SearchGuestData(
      vehicle_number: map['vehicle_number'],
      customer_name: map['customer_name'],
      mobile_number: map['mobile_number'],
      vehicle_type: map['vehicle_type'],
      display_string:
          "${map['vehicle_number'] ?? ""} | ${map['customer_name'] ?? ""} | ${map['mobile_number'] ?? ""} ",
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchGuestData.fromJson(String source) =>
      SearchGuestData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchGuestData(vehicle_number: $vehicle_number, customer_name: $customer_name, mobile_number: $mobile_number, vehicle_type: $vehicle_type, display_string: $display_string)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchGuestData &&
        other.vehicle_number == vehicle_number &&
        other.customer_name == customer_name &&
        other.mobile_number == mobile_number &&
        other.vehicle_type == vehicle_type &&
        other.display_string == display_string;
  }

  @override
  int get hashCode {
    return vehicle_number.hashCode ^
        customer_name.hashCode ^
        mobile_number.hashCode ^
        vehicle_type.hashCode ^
        display_string.hashCode;
  }
}
