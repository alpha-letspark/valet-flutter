import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:valet_app/Data/Response/SearchGuestData.dart';

class SearchGuestResponse {
  int? status;
  String? message;
  List<SearchGuestData>? data;
  SearchGuestResponse({
    this.status,
    this.message,
    this.data,
  });

  SearchGuestResponse copyWith({
    int? status,
    String? message,
    List<SearchGuestData>? data,
  }) {
    return SearchGuestResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  // factory SearchGuestResponse.fromJson(String source) =>
  //     SearchGuestResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SearchGuestResponse(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchGuestResponse &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  factory SearchGuestResponse.fromJson(Map<String, dynamic> map) {
    return SearchGuestResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      data: map['status'] == 0 // as map['data'] can be the list or string
          ? null
          : map['data'] != null
              ? List<SearchGuestData>.from(
                  map['data']?.map((x) => SearchGuestData.fromMap(x)))
              : null,
    );
  }
}
