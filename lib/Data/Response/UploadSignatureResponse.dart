import 'dart:convert';

class UploadSignatureResponse {
  int? status;
  String? message;
  String? file_name;
  String? url;

  UploadSignatureResponse({
    this.status,
    this.message,
    this.file_name,
    this.url,
  });

  UploadSignatureResponse copyWith({
    int? status,
    String? message,
    String? file_name,
    String? url,
  }) {
    return UploadSignatureResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      file_name: file_name ?? this.file_name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'file_name': file_name,
      'url': url,
    };
  }

  factory UploadSignatureResponse.fromJson(Map<String, dynamic> map) {
    return UploadSignatureResponse(
      status: map['status']?.toInt(),
      message: map['message'],
      file_name: map['file_name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UploadSignatureResponse(status: $status, message: $message, file_name: $file_name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UploadSignatureResponse &&
        other.status == status &&
        other.message == message &&
        other.file_name == file_name &&
        other.url == url;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        file_name.hashCode ^
        url.hashCode;
  }
}
