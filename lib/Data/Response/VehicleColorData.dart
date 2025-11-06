import 'dart:convert';

class VehicleColorData {
  String? color_name;
  VehicleColorData({
    this.color_name,
  });

  VehicleColorData copyWith({
    String? color_name,
  }) {
    return VehicleColorData(
      color_name: color_name ?? this.color_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color_name': color_name,
    };
  }

  factory VehicleColorData.fromMap(Map<String, dynamic> map) {
    return VehicleColorData(
      color_name: map['color_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleColorData.fromJson(String source) =>
      VehicleColorData.fromMap(json.decode(source));

  @override
  String toString() => 'VehicleColorData(color_name: $color_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleColorData && other.color_name == color_name;
  }

  @override
  int get hashCode => color_name.hashCode;
}
