import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:valet_app/Database/Tables/ImageUploadTable.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  Database? _db;

  DatabaseProvider._internal();

  Future<Database?> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'letspark.db');

    _db = await openDatabase(path,
        version: 1, onUpgrade: _onUpgrade, onCreate: _onCreate);
    isInitialized = true;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  _onCreate(Database db, int version) async {
    await db.execute(ImageUploadTable().createTableQuery);
  }
}
