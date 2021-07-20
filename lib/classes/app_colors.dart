import 'package:flutter/material.dart';

/// Guarda as cores do app
class AppColors {
  AppColors._();

  /// Instancia da classe. Sim, é um singleton
  static final AppColors instance = AppColors._();

  /// Mapa que guarda as cores do app
  ///
  /// Uso: AppColors.instance.colors["background"] ==> cor background
  Map<String, Color> colors = {
    "main": Color(0xFFFFC107), // Colors.amber
    "background": Color(0xFF212121) // Colors.grey[900]
  };

  /// Altera as cores do app. Recebe a cor a ser alterada e o ID de onde será alterado.
  ///
  /// Exemplo:
  /// changeColor(Colors.red, "main") -> altera a cor principal para vermelho
  changeColor(Color color, String colorID) {
    switch (colorID) {
      case "main":
        colors["main"] = color;
        break;
      case "background":
        colors["background"] = color;
        break;
      default:
        break;
    }
    // TODO: Salvar alterações no banco de dados ou no shared preferences
  }
}
