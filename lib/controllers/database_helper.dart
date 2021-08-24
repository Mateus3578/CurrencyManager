import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:currency_manager/models/DAO/account_DAO.dart';
import 'package:currency_manager/models/DAO/transaction_DAO.dart';
import 'package:currency_manager/models/DAO/user_DAO.dart';

class DatabaseHelper {
  // Singleton
  DatabaseHelper._();

  /// Comunicação com o banco de dados local.
  static final DatabaseHelper instance = DatabaseHelper._();
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
    await db.execute(TransactionDAO().createTableTransactions);
    await db.execute(AccountDAO().createTableAccounts);
    await db.execute(UserDAO().createTableUserPrefs);
    await db.insert(
      UserModelForDb.tableName,
      {
        UserModelForDb.userId: "1",
        UserModelForDb.name: "usuário",
        UserModelForDb.backgroundColor: "0xFF212121",
        UserModelForDb.primaryColor: "0xFFFFC107",
        UserModelForDb.alterColor: "0xFFFF9800",
        UserModelForDb.iconColor: "0xFF000000",
        UserModelForDb.textColor: "0xFFFFFFFF",
        UserModelForDb.isDarkMode: true
      },
    );
    await db.insert(
      AccountModelForDb.tableName,
      {AccountModelForDb.name: "Carteira", AccountModelForDb.balance: 0},
    );
  }
}
