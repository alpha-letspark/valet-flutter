import 'dart:convert';

class DriverListData {
  int? id;
  String? name;
  DriverListData({
    this.id,
    this.name,
  });

  DriverListData copyWith({
    int? id,
    String? name,
  }) {
    return DriverListData(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory DriverListData.fromMap(Map<String, dynamic> map) {
    return DriverListData(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverListData.fromJson(String source) =>
      DriverListData.fromMap(json.decode(source));

  @override
  String toString() => 'DriverListData(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverListData && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
