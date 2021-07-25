/// Para não errar os nomes
class UserForDb {
  static String userId = "userId";
  static String name = "name";
  static String backgroundColor = "backgroundColor";
  static String mainColor = "mainColor";

  static String tableName = "userPrefs";
}

class User {
  final int userId;
  final String name;
  final String backgroundColor;
  final String mainColor;

  //TODO: Cor do ícone
  //TODO: Cor do texto

  User({
    required this.userId,
    required this.name,
    required this.backgroundColor,
    required this.mainColor,
  });

  User.fromMap(Map<String, dynamic> map)
      : userId = map[UserForDb.userId],
        name = map[UserForDb.name],
        backgroundColor = map[UserForDb.backgroundColor],
        mainColor = map[UserForDb.mainColor];

  /// Retorna todos os dados do usuário
  Map<String, Object?> toMap() {
    return {
      UserForDb.userId: userId,
      UserForDb.name: name,
      UserForDb.backgroundColor: backgroundColor,
      UserForDb.mainColor: mainColor
    };
  }
}
