import 'package:sqflite/sqflite.dart';
import 'package:currency_manager/controllers/database_helper.dart';
import 'package:currency_manager/models/user_model.dart';

class UserDAO {
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  /// Altera configurações do usuário no db. Uma de cada vez.
  Future<int> updateUserPrefs(String prefName, String newPref) async {
    Database db = await dbHelper.database;
    int rowsAffected = await db.update(
      UserModelForDb.tableName,
      // Simulação de mapa
      {prefName: newPref},
      where: "${UserModelForDb.userId} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Updated $rowsAffected rows on ${UserModelForDb.tableName}");
    return rowsAffected;
  }

  /// Altera várias configurações do usuário no db, usando um mapa.
  Future<int> updateTheme(Map<String, dynamic> map) async {
    Database db = await dbHelper.database;
    int rowsAffected = await db.update(
      UserModelForDb.tableName,
      map,
      where: "${UserModelForDb.userId} = ?",
      whereArgs: [1],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Updated $rowsAffected rows on ${UserModelForDb.tableName}");
    return rowsAffected;
  }

  /// Busca os dados do usuário.
  Future<UserModel> getUserPrefs() async {
    Database db = await dbHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      UserModelForDb.tableName,
    );
    return UserModel.fromMap(result[0]);
  }

  // Query de criação da tabela
  String get createTableUserPrefs => '''
    CREATE TABLE ${UserModelForDb.tableName} (
      ${UserModelForDb.userId} INTEGER,
      ${UserModelForDb.name} TEXT,
      ${UserModelForDb.backgroundColor} TEXT,
      ${UserModelForDb.primaryColor} TEXT,
      ${UserModelForDb.alterColor} TEXT,
      ${UserModelForDb.iconColor} TEXT,
      ${UserModelForDb.textColor} TEXT,
      ${UserModelForDb.isDarkMode} BOOLEAN
    )
  ''';
}

/// Para não errar os nomes
class UserModelForDb {
  static String userId = "userId";
  static String name = "name";
  static String backgroundColor = "backgroundColor";
  static String primaryColor = "primaryColor";
  static String alterColor = "alterColor";
  static String iconColor = "iconColor";
  static String textColor = "textColor";
  static String isDarkMode = "isDarkMode";

  static String tableName = "userPrefs";
}
