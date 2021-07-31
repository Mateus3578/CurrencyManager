import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/models/user_model.dart';

class DatabaseHelper {
  // Singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  static final _databaseName = "app_database.db"; //TODO: Mudar?
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

  /// Funções de criação do db.
  _onCreate(db, versao) async {
    await db.execute(_createTransactions);
    await db.execute(_createAccounts);
    await db.execute(_createUserPrefs);
    await db.insert(
      UserModelForDb.tableName,
      {
        UserModelForDb.userId: "1",
        UserModelForDb.name: "usuário",
        UserModelForDb.backgroundColor: "0xFF212121",
        UserModelForDb.primaryColor: "0xFFFFC107",
        UserModelForDb.alterColor: "0xFFFF9800",
        UserModelForDb.iconColor: "0xFF000000",
        UserModelForDb.textColor: "0xFFFFFFFF"
      },
    );
  }

  /// Altera configurações do usuário no db. Uma de cada vez.
  Future<int> updateUserPrefs(String prefName, String newPref) async {
    Database db = await database;
    int rowsAffected = await db.update(
      UserModelForDb.tableName,
      {prefName: newPref},
      where: "${UserModelForDb.userId} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Updated $rowsAffected rows on ${UserModelForDb.tableName}");
    return rowsAffected;
  }

  /// Busca os dados do usuário.
  Future<UserModel> getUserPrefs() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(UserModelForDb.tableName);
    return UserModel.fromMap(result[0]);
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
  Future<List<TransactionModel>> getTransactionsByPeriod(
      String firstDate, String lastDate) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      TransactionModelForDb.tableName,
      where:
          "${TransactionModelForDb.date} >= ? and ${TransactionModelForDb.date} <= ?",
      whereArgs: [firstDate, lastDate],
      orderBy: TransactionModelForDb.date,
    );
    List<TransactionModel> transactions = [];
    for (int i = 0; i < result.length; i++) {
      transactions.add(TransactionModel.fromMap(result[i]));
    }
    return transactions;
  }

  /// Busca no db todas as transações.
  /// Retorna uma lista de transações ordenada por data.
  Future<List<TransactionModel>> getAllTransactions() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      TransactionModelForDb.tableName,
      orderBy: TransactionModelForDb.date,
    );
    List<TransactionModel> transactions = [];
    for (int i = 0; i < result.length; i++) {
      transactions.add(TransactionModel.fromMap(result[i]));
    }
    return transactions;
  }

  Future<int> updateTransactionById(Map<String, dynamic> map, int id) async {
    Database db = await database;
    int rowsAffected = await db.update(
      TransactionModelForDb.tableName,
      map,
      where: "${TransactionModelForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Updated $rowsAffected rows on ${TransactionModelForDb.tableName}");
    return rowsAffected;
  }

  Future<int> deleteTransactionById(int id) async {
    Database db = await database;
    int rowsAffected = await db.delete(
      TransactionModelForDb.tableName,
      where: "${TransactionModelForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Deleted $rowsAffected rows on ${TransactionModelForDb.tableName}");
    return rowsAffected;
  }

  String get _createTransactions => '''
    CREATE TABLE ${TransactionModelForDb.tableName} (
      ${TransactionModelForDb.idTransaction} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${TransactionModelForDb.type} INTEGER,
      ${TransactionModelForDb.description} TEXT,
      ${TransactionModelForDb.accountId} INTEGER,
      ${TransactionModelForDb.value} REAL,
      ${TransactionModelForDb.date} TEXT,
      ${TransactionModelForDb.moreDesc} TEXT,
      ${TransactionModelForDb.isFixed} BOOLEAN,
      ${TransactionModelForDb.isRepeatable} BOOLEAN
    )
  ''';

  String get _createAccounts => '''
    CREATE TABLE ${AccountModelForDb.tableName} (
      ${AccountModelForDb.idAccount} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AccountModelForDb.name} TEXT,
      ${AccountModelForDb.balance} REAL
    )
  ''';

  String get _createUserPrefs => '''
    CREATE TABLE ${UserModelForDb.tableName} (
      ${UserModelForDb.userId} INTEGER,
      ${UserModelForDb.name} TEXT,
      ${UserModelForDb.backgroundColor} TEXT,
      ${UserModelForDb.primaryColor} TEXT,
      ${UserModelForDb.alterColor} TEXT,
      ${UserModelForDb.iconColor} TEXT,
      ${UserModelForDb.textColor} TEXT
    )
  ''';
}
