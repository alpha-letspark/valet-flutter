import 'dart:convert';

class ImageUploadData {
  int? id;
  String? filePath;
  String? transcationId;
  bool? isUploaded;
  ImageUploadData({
    this.id,
    this.filePath,
    this.transcationId,
    this.isUploaded,
  });

  ImageUploadData copyWith({
    int? id,
    String? filePath,
    String? transcationId,
    bool? isUploaded,
  }) {
    return ImageUploadData(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      transcationId: transcationId ?? this.transcationId,
      isUploaded: isUploaded ?? this.isUploaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'filePath': filePath,
      'transcationId': transcationId,
      'isUploaded': isUploaded,
    };
  }

  factory ImageUploadData.fromMap(Map<String, dynamic> map) {
    return ImageUploadData(
      id: map['id']?.toInt(),
      filePath: map['filePath'],
      transcationId: map['transcationId'],
      isUploaded: map['isUploaded'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUploadData.fromJson(String source) =>
      ImageUploadData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageUploadData(id: $id, filePath: $filePath, transcationId: $transcationId, isUploaded: $isUploaded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageUploadData &&
        other.id == id &&
        other.filePath == filePath &&
        other.transcationId == transcationId &&
        other.isUploaded == isUploaded;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        filePath.hashCode ^
        transcationId.hashCode ^
        isUploaded.hashCode;
  }
}
