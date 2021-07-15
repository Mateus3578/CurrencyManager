import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), "app_database.db"),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_transactions);
    await db.execute(_accounts);
  }

  String get _transactions => '''
    CREATE TABLE transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      description TEXT NOT NULL,
      account TEXT NOT NULL,
      value REAL NOT NULL,
      date TEXT NOT NULL,
      moreDesc TEXT,
      category TEXT,
      isFixed BOOLEAN NOT NULL,
      isAdded BOOLEAN NOT NULL
    );
  ''';

  String get _accounts => '''
    CREATE TABLE accounts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      balance REAL NOT NULL
    );
  ''';
}
