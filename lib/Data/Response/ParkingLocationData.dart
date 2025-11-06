import 'dart:convert';

class ParkingLocationData {
  int? id;
  String? name;
  String? color_code;
  String? capacity;
  ParkingLocationData({
    this.id,
    this.name,
    this.color_code,
    this.capacity,
  });

  ParkingLocationData copyWith({
    int? id,
    String? name,
    String? color_code,
    String? capacity,
  }) {
    return ParkingLocationData(
      id: id ?? this.id,
      name: name ?? this.name,
      color_code: color_code ?? this.color_code,
      capacity: capacity ?? this.capacity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color_code': color_code,
      'capacity': capacity,
    };
  }

  factory ParkingLocationData.fromMap(Map<String, dynamic> map) {
    return ParkingLocationData(
      id: map['id']?.toInt(),
      name: map['name'],
      color_code: map['color_code'],
      capacity: map['capacity'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingLocationData.fromJson(String source) =>
      ParkingLocationData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParkingLocationData(id: $id, name: $name, color_code: $color_code, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParkingLocationData &&
        other.id == id &&
        other.name == name &&
        other.color_code == color_code &&
        other.capacity == capacity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color_code.hashCode ^
        capacity.hashCode;
  }
}
