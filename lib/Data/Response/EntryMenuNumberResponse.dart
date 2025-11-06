import 'dart:convert';

class EntryMenuNumberResponse {
  int? status;
  String? total_checkin;
  String? total_checkout;
  String? total_request;
  String? total_exit;
  EntryMenuNumberResponse({
    this.status,
    this.total_checkin,
    this.total_checkout,
    this.total_request,
    this.total_exit,
  });

  EntryMenuNumberResponse copyWith({
    int? status,
    String? total_checkin,
    String? total_checkout,
    String? total_request,
    String? total_exit,
  }) {
    return EntryMenuNumberResponse(
      status: status ?? this.status,
      total_checkin: total_checkin ?? this.total_checkin,
      total_checkout: total_checkout ?? this.total_checkout,
      total_request: total_request ?? this.total_request,
      total_exit: total_exit ?? this.total_exit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'total_checkin': total_checkin,
      'total_checkout': total_checkout,
      'total_request': total_request,
      'total_exit': total_exit,
    };
  }

  factory EntryMenuNumberResponse.fromJson(Map<String, dynamic> map) {
    return EntryMenuNumberResponse(
      status: map['status']?.toInt(),
      total_checkin: map['total_checkin'],
      total_checkout: map['total_checkout'],
      total_request: map['total_request'],
      total_exit: map['total_exit'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'EntryMenuNumberResponse(status: $status, total_checkin: $total_checkin, total_checkout: $total_checkout, total_request: $total_request, total_exit: $total_exit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EntryMenuNumberResponse &&
        other.status == status &&
        other.total_checkin == total_checkin &&
        other.total_checkout == total_checkout &&
        other.total_request == total_request &&
        other.total_exit == total_exit;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        total_checkin.hashCode ^
        total_checkout.hashCode ^
        total_request.hashCode ^
        total_exit.hashCode;
  }

  factory EntryMenuNumberResponse.fromMap(Map<String, dynamic> map) {
    return EntryMenuNumberResponse(
      status: map['status']?.toInt(),
      total_checkin: map['total_checkin'],
      total_checkout: map['total_checkout'],
      total_request: map['total_request'],
      total_exit: map['total_exit'],
    );
  }
}
