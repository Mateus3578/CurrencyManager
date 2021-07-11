import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE transactions()",
        );
      },
      version: 1,
    );
  }
}

/*
  int idTransaction;
  String type;
  String description;
  String moreDesc;
  Account account;
  double value;
  String category;
  int isFixed;
  int isAdded;
*/