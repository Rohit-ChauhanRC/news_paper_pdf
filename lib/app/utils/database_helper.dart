import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:news_paper_pdf/app/data/models/news_article.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "news.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE articles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        link TEXT,
        date TEXT
      )
    ''');
  }

  Future<int> insertArticle(NewsArticle article, String date) async {
    final dbClient = await db;
    return await dbClient.insert(
      "articles",
      {
        "title": article.title,
        "link": article.link,
        "date": date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsArticle>> getArticlesByDate(String date) async {
    final dbClient = await db;
    final result =
        await dbClient.query("articles", where: "date = ?", whereArgs: [date]);

    return result.map((e) => NewsArticle.fromJson(e)).toList();
  }

  Future<List<NewsArticle>> getArticlesByDateAndTitle({
    required String date,
    required String title,
  }) async {
    final dbClient = await db;

    final result = await dbClient.query(
      "articles",
      where: "date = ? AND title = ?",
      whereArgs: [date, title],
    );

    return result.map((e) => NewsArticle.fromJson(e)).toList();
  }

  Future<void> clearOldArticles(String date) async {
    final dbClient = await db;
    await dbClient.delete("articles", where: "date != ?", whereArgs: [date]);
  }
}
