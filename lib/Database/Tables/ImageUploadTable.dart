import 'package:valet_app/Data/ImageUploadData.dart';

import '../Dao.dart';

class ImageUploadTable implements Dao<ImageUploadData> {
  static final tbName = 'imageupload';
  final tableName = 'Header';
  final id = 'id';
  final file_path = 'file_path';
  final transaction_id = 'transaction_id';
  final isUploaded = 'isUploaded';

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      " $file_path TEXT,"
      " $transaction_id TEXT,"
      " $isUploaded INTEGER)";

  @override
  ImageUploadData fromMap(Map<String, dynamic> query) {
    // TODO: implement fromMap
    ImageUploadData imageUpload = ImageUploadData();
    imageUpload.id = query[id];
    imageUpload.filePath = query[file_path];
    imageUpload.transcationId = query[transaction_id];
    imageUpload.isUploaded = query[isUploaded] == 1;
    return imageUpload;
  }

  @override
  Map<String, dynamic> toMap(ImageUploadData object) {
    return <String, dynamic>{
      file_path: object.filePath,
      transaction_id: object.transcationId,
      isUploaded: object.isUploaded == true ? 1 : 0,
    };
  }

  @override
  List<ImageUploadData> fromList(List<Map<String, dynamic>> query) {
    List<ImageUploadData> headerList = [];
    for (Map map in query) {
      headerList.add(fromMap(map as Map<String, dynamic>));
    }
    return headerList;
  }
}
