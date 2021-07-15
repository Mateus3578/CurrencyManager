class Account {
  final int idAccount;
  final String name;
  final double balance;

  Account({required this.idAccount, required this.name, required this.balance});

  Account.fromMap(Map<String, dynamic> map)
      : idAccount = map["idAccount"],
        name = map["name"],
        balance = map["balance"];

  /// Retorna todos os dados da conta
  Map<String, Object?> toMap() {
    return {"idAccount": idAccount, "name": name, "balance": balance};
  }
}
