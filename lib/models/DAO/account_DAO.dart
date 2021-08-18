import 'package:sqflite/sqflite.dart';
import 'package:tc/controllers/database_helper.dart';
import 'package:tc/models/account_model.dart';

class AccountDAO {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  /// Insere uma nova conta no db.
  Future<int> insertAccount(Map<String, dynamic> map) async {
    Database db = await dbHelper.database;
    int id = await db.insert(
      AccountModelForDb.tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Inserted on ${AccountModelForDb.tableName} with id = $id");
    return id;
  }

  /// Busca no db todas as contas e retorna uma lista de contas.
  Future<List<AccountModel>> getAllAccounts() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      AccountModelForDb.tableName,
    );

    List<AccountModel> accounts = [];
    for (int i = 0; i < result.length; i++) {
      accounts.add(AccountModel.fromMap(result[i]));
    }
    return accounts;
  }

  /// Altera o saldo de uma conta com base no seu id
  Future<int> updateBalanceById(double? newBalance, int? id) async {
    Database db = await dbHelper.database;
    int rowsAffected = await db.update(
      AccountModelForDb.tableName,
      {AccountModelForDb.balance: newBalance},
      where: "${AccountModelForDb.idAccount} = ?",
      whereArgs: [id],
    );
    print("Updated $rowsAffected rows on ${AccountModelForDb.tableName}");
    return rowsAffected;
  }

  String get createTableAccounts => '''
    CREATE TABLE ${AccountModelForDb.tableName} (
      ${AccountModelForDb.idAccount} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AccountModelForDb.name} TEXT,
      ${AccountModelForDb.balance} REAL
    )
  ''';
}

/// Para não errar os nomes
class AccountModelForDb {
  static String idAccount = "accountId";
  static String name = "name";
  static String balance = "balance";

  static String tableName = "accounts";
}
