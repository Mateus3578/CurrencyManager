/// Para não errar os nomes
class AccountModelForDb {
  static String idAccount = "accountId";
  static String name = "name";
  static String balance = "balance";

  static String tableName = "accounts";
}

class AccountModel {
  final int idAccount;
  final String name;
  final double balance;

  AccountModel(
      {required this.idAccount, required this.name, required this.balance});

  AccountModel.fromMap(Map<String, dynamic> map)
      : idAccount = map[AccountModelForDb.idAccount],
        name = map[AccountModelForDb.name],
        balance = map[AccountModelForDb.balance];

  /// Retorna todos os dados da conta
  Map<String, Object?> toMap() {
    return {
      AccountModelForDb.idAccount: idAccount,
      AccountModelForDb.name: name,
      AccountModelForDb.balance: balance
    };
  }
}
