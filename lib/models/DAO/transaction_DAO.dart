import 'package:sqflite/sqflite.dart';
import 'package:tc/controllers/database_helper.dart';
import 'package:tc/models/transaction_model.dart';

class TransactionDAO {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  /// Insere uma transação no db.
  Future<int> insertTransaction(Map<String, dynamic> map) async {
    Database db = await dbHelper.database;
    int id = await db.insert(
      TransactionModelForDb.tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted on ${TransactionModelForDb.tableName} with id = $id");
    return id;
  }

  /// Busca no db todas as transações dentro de um período.
  /// Retorna uma lista de transações ordenada por data.
  ///
  /// A data deve ser no formato yyyy-mm-dd.
  ///
  /// Ex.:
  ///
  /// firstDate = "2021-01-01"
  ///
  /// lastDate = "2020-05-27"
  Future<List<TransactionModel>> getTransactionsByPeriod(
    String firstDate,
    String lastDate,
  ) async {
    Database db = await dbHelper.database;
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
    Database db = await dbHelper.database;
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

  /// Altera uma transação com base no seu id
  Future<int> updateTransactionById(Map<String, dynamic> map, int id) async {
    Database db = await dbHelper.database;
    int rowsAffected = await db.update(
      TransactionModelForDb.tableName,
      map,
      where: "${TransactionModelForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Updated $rowsAffected rows on ${TransactionModelForDb.tableName}");
    return rowsAffected;
  }

  /// Apaga uma transação com base no seu id
  Future<int> deleteTransactionById(int id) async {
    Database db = await dbHelper.database;
    int rowsAffected = await db.delete(
      TransactionModelForDb.tableName,
      where: "${TransactionModelForDb.idTransaction} = ?",
      whereArgs: [id],
    );
    print("Deleted $rowsAffected row(s) on ${TransactionModelForDb.tableName}");
    return rowsAffected;
  }

  String get createTableTransactions => '''
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
}

/// Para não errar os nomes
class TransactionModelForDb {
  static String idTransaction = "transactionId";
  static String type = "type";
  static String description = "description";
  static String accountId = "accountId";
  static String value = "value";
  static String date = "date";
  static String moreDesc = "moreDesc";
  static String isFixed = "isFixed";
  static String isRepeatable = "isRepeatable";

  static String tableName = "transactions";
}
