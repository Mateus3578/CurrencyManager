import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tc/models/account.dart';
import 'package:tc/models/transaction.dart' as tr; //conflito com o sqflite

class AppDatabase {
  // Singleton
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  static final _databaseName = "app_database.db";
  static final _databaseVersion = 1;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_createTransactions);
    await db.execute(_createAccounts);
  }

  Future<int> insert(String tableName, Map<String, dynamic> map) async {
    Database db = await database;
    int id = await db.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted on $tableName with id = $id");
    return id;
  }

  /// Busca no db todas as transações dentro de um período.
  /// Retorna uma lista de transações ordenada por data
  Future<List<tr.Transaction>> getTransactionsByPeriod(
      String firstDate, String lastDate) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tr.TransactionForDb.tableName,
      where: "date >= ? and date <= ?",
      whereArgs: [firstDate, lastDate],
      orderBy: "date",
    );
    List<tr.Transaction> transactions = [];
    for (int i = 0; i < result.length; i++) {
      transactions.add(tr.Transaction.fromMap(result[i]));
    }

    return transactions;
  }

  /// Busca no db todas as transações.
  /// Retorna uma lista de transações ordenada por data.
  Future<List<tr.Transaction>> getAllTransactions() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tr.TransactionForDb.tableName,
      orderBy: "date",
    );
    List<tr.Transaction> transactions = [];
    for (int i = 0; i < result.length; i++) {
      transactions.add(tr.Transaction.fromMap(result[i]));
    }

    return transactions;
  }

  Future<int> updateSomethingById(
      String tableName, Map<String, dynamic> map, int id) async {
    Database db = await database;
    int rowsAffected = await db.update(
      tableName,
      map,
      where: "id = ?",
      whereArgs: [id],
    );
    print("Updated $rowsAffected rows on $tableName");
    return rowsAffected;
  }

  Future<int> deleteSomethingById(String tableName, int id) async {
    Database db = await database;
    int rowsAffected = await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    print("Deleted $rowsAffected rows on $tableName");
    return rowsAffected;
  }

  String get _createTransactions => '''
    CREATE TABLE ${tr.TransactionForDb.tableName} (
      ${tr.TransactionForDb.idTransaction} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${tr.TransactionForDb.type} INTEGER,
      ${tr.TransactionForDb.description} TEXT,
      ${tr.TransactionForDb.accountId} INTEGER,
      ${tr.TransactionForDb.value} REAL,
      ${tr.TransactionForDb.date} TEXT,
      ${tr.TransactionForDb.moreDesc} TEXT,
      ${tr.TransactionForDb.isFixed} BOOLEAN,
      ${tr.TransactionForDb.isRepeatable} BOOLEAN
    )
  ''';

  String get _createAccounts => '''
    CREATE TABLE ${AccountForDb.tableName} (
      ${AccountForDb.idAccount} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AccountForDb.name} TEXT,
      ${AccountForDb.balance} REAL
    )
  ''';
}
