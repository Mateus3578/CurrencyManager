import 'package:flutter/material.dart';
import 'package:tc/models/DAO/user_DAO.dart';
import 'package:tc/models/user_model.dart';

class ThemeProvider extends ChangeNotifier {
  // Configurações padrão do app
  String _username = "usuário";
  Color _primaryColor = Colors.amber;
  Color _alterColor = Colors.orange;
  Color _backgroundColor = Color(0xFF212121);
  Color _textColor = Colors.white;
  Color _iconColor = Colors.black;

  /// Busca as cores guardadas no db.
  fetchData() async {
    UserDAO userDAO = UserDAO();
    UserModel userPrefs = await userDAO.getUserPrefs();

    if (userPrefs.primaryColor.isNotEmpty)
      setPrimaryColor(Color(int.parse(userPrefs.primaryColor)));
    if (userPrefs.alterColor.isNotEmpty)
      setAlterColor(Color(int.parse(userPrefs.alterColor)));
    if (userPrefs.backgroundColor.isNotEmpty)
      setBackgroundColor(Color(int.parse(userPrefs.backgroundColor)));
    if (userPrefs.textColor.isNotEmpty)
      setTextColor(Color(int.parse(userPrefs.textColor)));
    if (userPrefs.iconColor.isNotEmpty)
      setIconColor(Color(int.parse(userPrefs.iconColor)));

    if (userPrefs.name.isNotEmpty) setUsername(userPrefs.name);
  }

  // Getters
  get textColor => _textColor;
  get alterColor => _alterColor;
  get primaryColor => _primaryColor;
  get backgroundColor => _backgroundColor;
  get iconColor => _iconColor;

  get username => _username;

  // Setters
  setTextColor(Color color) {
    _textColor = color;
    notifyListeners();
  }

  setPrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }

  setAlterColor(Color color) {
    _alterColor = color;
    notifyListeners();
  }

  setBackgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  setIconColor(Color color) {
    _iconColor = color;
    notifyListeners();
  }

  setUsername(String username) {
    _username = username;
    notifyListeners();
  }
}
