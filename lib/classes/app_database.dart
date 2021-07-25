import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tc/models/account.dart';
import 'package:tc/models/transaction.dart' as tr; //conflito com o sqflite
import 'package:tc/models/user.dart';

class AppDatabase {
  // Singleton
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  static final _databaseName = "app_database.db"; //TODO: Mudar?
  static final _databaseVersion = 1;

  get database async {
    if (_database != null) {
      return _database;
    }
    return await _initDatabase();
  }

  /// Esse método só roda se o app não encontrar uma db.
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  /// Funções de criação do db.
  _onCreate(db, versao) async {
    await db.execute(_createTransactions);
    await db.execute(_createAccounts);
    await db.execute(_createUserPrefs);
    await db.insert(
      UserForDb.tableName,
      {
        UserForDb.userId: "1",
        UserForDb.name: "usuário",
        UserForDb.backgroundColor: "0xFF212121",
        UserForDb.mainColor: "0xFFFFC107"
      },
    );
  }

  /// Altera configurações do usuário no db. Uma de cada vez.
  Future<int> updateUserPrefs(String prefName, String newPref) async {
    Database db = await database;
    int rowsAffected = await db.update(
      UserForDb.tableName,
      {prefName: newPref},
      where: "${UserForDb.userId} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Updated $rowsAffected rows on ${UserForDb.tableName}");
    return rowsAffected;
  }

  /// Busca os dados do usuário.
  Future<User> getUserPrefs() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(UserForDb.tableName);
    return User.fromMap(result[0]);
  }

  /// Insere um dado no db.
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
      where:
          "${tr.TransactionForDb.date} >= ? and ${tr.TransactionForDb.date} <= ?",
      whereArgs: [firstDate, lastDate],
      orderBy: tr.TransactionForDb.date,
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
      orderBy: tr.TransactionForDb.date,
    );
    List<tr.Transaction> transactions = [];
    for (int i = 0; i < result.length; i++) {
      transactions.add(tr.Transaction.fromMap(result[i]));
    }
    return transactions;
  }

  Future<int> updateTransactionById(Map<String, dynamic> map, int id) async {
    Database db = await database;
    int rowsAffected = await db.update(
      tr.TransactionForDb.tableName,
      map,
      where: "${tr.TransactionForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Updated $rowsAffected rows on ${tr.TransactionForDb.tableName}");
    return rowsAffected;
  }

  Future<int> deleteTransactionById(int id) async {
    Database db = await database;
    int rowsAffected = await db.delete(
      tr.TransactionForDb.tableName,
      where: "${tr.TransactionForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Deleted $rowsAffected rows on ${tr.TransactionForDb.tableName}");
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

  String get _createUserPrefs => '''
    CREATE TABLE ${UserForDb.tableName} (
      ${UserForDb.userId} INTEGER,
      ${UserForDb.name} TEXT,
      ${UserForDb.backgroundColor} TEXT,
      ${UserForDb.mainColor} TEXT
    )
  ''';
}
