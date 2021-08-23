import 'package:tc/models/DAO/user_DAO.dart';

class UserModel {
  final int userId;
  final String name;
  final String backgroundColor;
  final String primaryColor;
  final String alterColor;
  final String iconColor;
  final String textColor;
  final bool isDarkMode;

  /// Model de preferências do usuário
  ///
  /// Apesar de possuir um id, ele sempre será 1.
  /// Serve para ter certeza de não fazer algo errado e criar uma nova linha
  /// ou alterar outro lugar.
  ///
  /// Os atributos possuem nomes auto-explicativos.
  UserModel({
    this.userId = 1,
    required this.name,
    required this.backgroundColor,
    required this.primaryColor,
    required this.alterColor,
    required this.iconColor,
    required this.textColor,
    required this.isDarkMode,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : userId = map[UserModelForDb.userId],
        name = map[UserModelForDb.name],
        backgroundColor = map[UserModelForDb.backgroundColor],
        primaryColor = map[UserModelForDb.primaryColor],
        alterColor = map[UserModelForDb.alterColor],
        iconColor = map[UserModelForDb.iconColor],
        textColor = map[UserModelForDb.textColor],
        isDarkMode = map[UserModelForDb.isDarkMode] == 0 ? false : true;

  Map<String, Object?> toMap() {
    return {
      UserModelForDb.name: name,
      UserModelForDb.backgroundColor: backgroundColor,
      UserModelForDb.primaryColor: primaryColor,
      UserModelForDb.alterColor: alterColor,
      UserModelForDb.iconColor: iconColor,
      UserModelForDb.textColor: textColor,
      UserModelForDb.isDarkMode: isDarkMode ? 1 : 0
    };
  }
}
