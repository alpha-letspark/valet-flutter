import 'dart:convert';

class CheckHookNumberResponse {
  int? status;
  String? message;
  CheckHookNumberResponse({
    this.status,
    this.message,
  });

  CheckHookNumberResponse copyWith({
    int? status,
    String? message,
  }) {
    return CheckHookNumberResponse(
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

  factory CheckHookNumberResponse.fromJson(Map<String, dynamic> map) {
    return CheckHookNumberResponse(
      status: map['status']?.toInt(),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'CheckHookNumberResponse(status: $status, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CheckHookNumberResponse &&
        other.status == status &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode;
}
