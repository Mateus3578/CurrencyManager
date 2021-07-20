/// Para não errar os nomes
class AccountForDb {
  static String idAccount = "idAccount";
  static String name = "name";
  static String balance = "balance";

  static String tableName = "accounts";
}

class Account {
  final int idAccount;
  final String name;
  final double balance;

  Account({required this.idAccount, required this.name, required this.balance});

  Account.fromMap(Map<String, dynamic> map)
      : idAccount = map[AccountForDb.idAccount],
        name = map[AccountForDb.name],
        balance = map[AccountForDb.balance];

  /// Retorna todos os dados da conta
  Map<String, Object?> toMap() {
    return {
      AccountForDb.idAccount: idAccount,
      AccountForDb.name: name,
      AccountForDb.balance: balance
    };
  }
}
