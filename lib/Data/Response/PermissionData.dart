import 'dart:convert';

class PermissionData {
  int? exit_by_pin;
  int? exit_by_hn;
  int? assign_req;

  PermissionData({
    this.exit_by_pin,
    this.exit_by_hn,
    this.assign_req,
  });

  PermissionData copyWith({
    int? exit_by_pin,
    int? exit_by_hn,
    int? assign_req,
  }) {
    return PermissionData(
      exit_by_pin: exit_by_pin ?? this.exit_by_pin,
      exit_by_hn: exit_by_hn ?? this.exit_by_hn,
      assign_req: assign_req ?? this.assign_req,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exit_by_pin': exit_by_pin,
      'exit_by_hn': exit_by_hn,
      'assign_req': assign_req,
    };
  }

  factory PermissionData.fromMap(Map<String, dynamic> map) {
    return PermissionData(
      exit_by_pin: map['exit_by_pin']?.toInt(),
      exit_by_hn: map['exit_by_hn']?.toInt(),
      assign_req: map['assign_req']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionData.fromJson(String source) =>
      PermissionData.fromMap(json.decode(source));

  @override
  String toString() =>
      'PermissionData(exit_by_pin: $exit_by_pin, exit_by_hn: $exit_by_hn, assign_req: $assign_req)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PermissionData &&
        other.exit_by_pin == exit_by_pin &&
        other.exit_by_hn == exit_by_hn &&
        other.assign_req == assign_req;
  }

  @override
  int get hashCode =>
      exit_by_pin.hashCode ^ exit_by_hn.hashCode ^ assign_req.hashCode;
}
