import 'dart:convert';

class VehicleTypeData {
  int? id;
  String? name;
  String? photos;
  VehicleTypeData({
    this.id,
    this.name,
    this.photos,
  });

  VehicleTypeData copyWith({
    int? id,
    String? name,
    String? photos,
  }) {
    return VehicleTypeData(
      id: id ?? this.id,
      name: name ?? this.name,
      photos: photos ?? this.photos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photos': photos,
    };
  }

  factory VehicleTypeData.fromMap(Map<String, dynamic> map) {
    return VehicleTypeData(
      id: map['id']?.toInt(),
      name: map['name'],
      photos: map['photos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleTypeData.fromJson(String source) =>
      VehicleTypeData.fromMap(json.decode(source));

  @override
  String toString() => 'VehicleTypeData(id: $id, name: $name, photos: $photos)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleTypeData &&
        other.id == id &&
        other.name == name &&
        other.photos == photos;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ photos.hashCode;
}
