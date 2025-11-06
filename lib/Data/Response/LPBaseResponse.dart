import 'dart:convert';

class LPBaseResponse {
  int? status;
  String? message;
  LPBaseResponse({
    this.status,
    this.message,
  });

  LPBaseResponse copyWith({
    int? status,
    String? message,
  }) {
    return LPBaseResponse(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
    };
  }

  factory LPBaseResponse.fromJson(Map<String, dynamic> map) {
    return LPBaseResponse(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'LPBaseResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LPBaseResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
