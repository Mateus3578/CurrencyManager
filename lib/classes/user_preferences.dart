import 'package:flutter/material.dart';
import 'package:tc/classes/app_database.dart';
import 'package:tc/models/user.dart';

/// Guarda as cores do app
class UserPreferences {
  UserPreferences._();

  /// Instancia da classe (singleton).
  static final UserPreferences instance = UserPreferences._();
  AppDatabase db = AppDatabase.instance;

  //Nome padrão, para caso de problema ao buscar no db.
  String username = "usuário";

  //TODO: Outro jeito de buscar a cor. Digitar o índice do mapa dá chance de erro.
  //* Algo como UserPreferences.instance.colors.background
  /// Mapa que guarda as cores do app
  ///
  /// Uso: AppColors.instance.colors["background"] ==> cor background
  Map<String, Color> colors = {
    // Cores padrão, para caso de algum problema ao buscar no db.
    "main": Colors.amber,
    "background": Color(0xFFFFC107), // Colors.grey[900]
    "icon": Colors.black,
    "text": Colors.black
  };

  /// Recarrega as preferências do usuário.
  reloadData() async {
    AppDatabase db = AppDatabase.instance;
    User userPrefs = await db.getUserPrefs();
    colors = {
      "main": Color(int.parse(userPrefs.mainColor)),
      "background": Color(int.parse(userPrefs.backgroundColor)),
      "icon": Colors.black, //!
      "text": Colors.black //TODO: Pegar do db
    };
    username = userPrefs.name;

    //TODO: E se der algum problema e os dados não vierem?
  }
}
