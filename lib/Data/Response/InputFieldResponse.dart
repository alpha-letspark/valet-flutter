import 'dart:convert';

import 'package:valet_app/Data/Response/InputFieldData.dart';

class InputFieldResponse {
  int? status;
  InputFieldData? data;
  InputFieldResponse({
    this.status,
    this.data,
  });

  InputFieldResponse copyWith({
    int? status,
    InputFieldData? data,
  }) {
    return InputFieldResponse(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.toMap(),
    };
  }

  factory InputFieldResponse.fromJson(Map<String, dynamic> map) {
    return InputFieldResponse(
      status: map['status']?.toInt(),
      data: map['data'] != null ? InputFieldData.fromMap(map['data']) : null,
    );
  }

  //String toJson() => json.encode(toMap());

  // factory InputFieldResponse.fromJson(String source) =>
  //     InputFieldResponse.fromMap(json.decode(source));

  @override
  String toString() => 'InputFieldResponse(status: $status, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputFieldResponse &&
        other.status == status &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}
