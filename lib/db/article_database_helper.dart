import 'package:hello_flutter/bean/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ArticleDatabaseHelper {
  static final ArticleDatabaseHelper instance = ArticleDatabaseHelper.internal();
  factory ArticleDatabaseHelper() => instance;
  ArticleDatabaseHelper.internal();
  
  static Database _db;

  final String table = "tb_article";
  final String columnId = "id";
  final String columnChapterName = "chapterName";
  final String columnTitle = "title";
  final String columnAuthor = "author";
  final String columnNiceDate = "niceDate";
  final String columnLink = "link";

  
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
        "$columnChapterName text,"
        "$columnTitle text,"
        "$columnAuthor text,"
        "$columnNiceDate text,"
        "$columnLink text)";
    await db.execute(sql);
    print("Table $table is created");
  }

  Future<int> insert(Article article) async {
    var client = await db;
    var result = await client.insert("$table", article.toMap());
    print(result.toString());
    return result;
  }

  Future<int> delete(Article article) async {
    var client = await db;
    var result = await client.delete("$table", where: "$columnId = ?", whereArgs: [article.id]);
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
