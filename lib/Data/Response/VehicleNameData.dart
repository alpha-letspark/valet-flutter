import 'dart:convert';

class VehicleNameData {
  String? name;
  VehicleNameData({
    this.name,
  });

  VehicleNameData copyWith({
    String? name,
  }) {
    return VehicleNameData(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory VehicleNameData.fromMap(Map<String, dynamic> map) {
    return VehicleNameData(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleNameData.fromJson(String source) =>
      VehicleNameData.fromMap(json.decode(source));

  @override
  String toString() => 'VehicleNameData(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleNameData && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
