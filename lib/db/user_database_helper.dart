import 'package:hello_flutter/bean/article.dart';
import 'package:hello_flutter/bean/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper instance = UserDatabaseHelper.internal();
  factory UserDatabaseHelper() => instance;
  UserDatabaseHelper.internal();
  
  static Database _db;

  final String table = "tb_user";
  final String columnId = "id";
  final String columnName = "name";
  final String columnAge = "age";

  
  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }
  
  initDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "GuafuaAndroid.db");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  
  void _onCreate(Database db, int version) async {
    String sql = "create table $table($columnId integer primary key, "
        "$columnName text,"
        "$columnAge text)";
    await db.execute(sql);
    print("Table $table is created");
  }

  Future<int> save(User user) async {
    var client = await db;
    var result = await client.insert("$table", user.toMap());
    print(result.toString());
    return result;
  }

  Future<List> getAll() async {
    var client = await db;
    String sql = "select * from $table";
    var result = await client.rawQuery(sql);
    return result.toList();
  }
}
