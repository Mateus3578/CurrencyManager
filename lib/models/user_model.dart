/// Para não errar os nomes
class UserModelForDb {
  static String userId = "userId";
  static String name = "name";
  static String backgroundColor = "backgroundColor";
  static String primaryColor = "primaryColor";
  static String alterColor = "alterColor";
  static String iconColor = "iconColor";
  static String textColor = "textColor";

  static String tableName = "userPrefs";
}

class UserModel {
  final int userId;
  final String name;
  final String backgroundColor;
  final String primaryColor;
  final String alterColor;
  final String iconColor;
  final String textColor;

  UserModel({
    required this.userId,
    required this.name,
    required this.backgroundColor,
    required this.primaryColor,
    required this.alterColor,
    required this.iconColor,
    required this.textColor,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : userId = map[UserModelForDb.userId],
        name = map[UserModelForDb.name],
        backgroundColor = map[UserModelForDb.backgroundColor],
        primaryColor = map[UserModelForDb.primaryColor],
        alterColor = map[UserModelForDb.alterColor],
        iconColor = map[UserModelForDb.iconColor],
        textColor = map[UserModelForDb.textColor];

  /// Retorna todos os dados do usuário
  Map<String, Object?> toMap() {
    return {
      UserModelForDb.userId: userId,
      UserModelForDb.name: name,
      UserModelForDb.backgroundColor: backgroundColor,
      UserModelForDb.primaryColor: primaryColor,
      UserModelForDb.alterColor: alterColor,
      UserModelForDb.iconColor: iconColor,
      UserModelForDb.textColor: textColor
    };
  }
}
