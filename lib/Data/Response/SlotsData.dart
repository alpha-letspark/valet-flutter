import 'dart:convert';

class SlotsData {
  String? name;
  SlotsData({
    this.name,
  });

  SlotsData copyWith({
    String? name,
  }) {
    return SlotsData(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory SlotsData.fromMap(Map<String, dynamic> map) {
    return SlotsData(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SlotsData.fromJson(String source) =>
      SlotsData.fromMap(json.decode(source));

  @override
  String toString() => 'SlotsData(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SlotsData && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
