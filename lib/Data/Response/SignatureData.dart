import 'dart:convert';

class SignatureData {
  String? signature_tc;
  SignatureData({
    this.signature_tc,
  });

  SignatureData copyWith({
    String? signature_tc,
  }) {
    return SignatureData(
      signature_tc: signature_tc ?? this.signature_tc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'signature_tc': signature_tc,
    };
  }

  factory SignatureData.fromMap(Map<String, dynamic> map) {
    return SignatureData(
      signature_tc: map['signature_tc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SignatureData.fromJson(String source) =>
      SignatureData.fromMap(json.decode(source));

  @override
  String toString() => 'SignatureData(signature_tc: $signature_tc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SignatureData && other.signature_tc == signature_tc;
  }

  @override
  int get hashCode => signature_tc.hashCode;
}
