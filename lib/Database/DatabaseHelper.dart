import 'package:sqflite/sqflite.dart';
import 'package:valet_app/Data/ImageUploadData.dart';
import 'package:valet_app/Database/DatabaseProvider.dart';
import 'package:valet_app/Database/Tables/ImageUploadTable.dart';

class DatabaseHelper {
  static final _instance = DatabaseHelper._internal();
  static DatabaseHelper get = _instance;
  bool isInitialized = false;
  Database? _db;
  DatabaseHelper._internal();

  Future<Database?> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databaseProvider = DatabaseProvider.get;
    _db = await databaseProvider.db();
    isInitialized = true;
  }

  var imageDao = ImageUploadTable();

  deleteAllMasters() async {
    await _db!.delete(imageDao.tableName);
  }

  Future<bool> insertImageData(List<ImageUploadData> header) async {
    try {
      Batch batch = _db!.batch();
      //Delete all first and then insert all
      batch.delete(imageDao.tableName);
      header.forEach((element) {
        batch.insert(imageDao.tableName, imageDao.toMap(element),
            conflictAlgorithm: ConflictAlgorithm.replace);
      });

      batch.commit();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<ImageUploadData>?> getImageFileByTranscationId(
      String? transactionId) async {
    List<Map> maps;
    maps = await _db!.query(imageDao.tableName,
        where: imageDao.transaction_id + "= ? COLLATE NOCASE",
        whereArgs: [transactionId]);
    List<ImageUploadData> imageData =
        imageDao.fromList(maps as List<Map<String, dynamic>>);
    if (imageData != null && imageData.isNotEmpty) {
      return imageData;
    } else {
      return null;
    }
  }

  Future<List<ImageUploadData>?> getAllPendingPhotoToUpload() async {
    List<Map> maps;
    maps = await _db!.query(imageDao.tableName,
        where: imageDao.isUploaded + "= ? ", whereArgs: [0]);
    List<ImageUploadData> imageData =
        imageDao.fromList(maps as List<Map<String, dynamic>>);
    if (imageData != null && imageData.isNotEmpty) {
      return imageData;
    } else {
      return null;
    }
  }

  Future<int> getPendingPhotoCount() async {
    var result = await _db!.rawQuery(
        "SELECT COUNT(*) FROM ${imageDao.tableName} WHERE ${imageDao.isUploaded} = ? ",
        [0]);
    var count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }

  Future<int> deleteById(int id) async {
    return await _db!.delete(imageDao.tableName,
        where: imageDao.id + " = ?", whereArgs: [id]);
  }

  Future<int> deleteByTranscationIdAndPath(
      int transcationId, String path) async {
    return await _db!.delete(imageDao.tableName,
        where: imageDao.transaction_id +
            " = ? AND " +
            imageDao.file_path +
            " = ? ",
        whereArgs: [transcationId, path]);
  }
}
