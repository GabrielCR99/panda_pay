import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String imageTable = 'imageTable';
final String idColumn = 'idColumn';
final String imageNameColumn = 'imageNameColumn';

class UserHelper {
  static final UserHelper _instance = UserHelper.internal();

  factory UserHelper() => _instance;

  UserHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'images.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newestVersion) async {
      await db.execute(
          'CREATE TABLE $imageTable($idColumn INTEGER PRIMARY KEY, $imageNameColumn TEXT)');
    });
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class User {
  int id;
  String imageName;

  User.fromMap(Map map) {
    id = map[idColumn];
    imageName = map[imageNameColumn];
  }

  User();

  Map toMap() {
    Map<String, dynamic> map = {imageNameColumn: imageName};
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }
}
