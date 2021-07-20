/// Para não errar os nomes
class TransactionForDb {
  static String idTransaction = "idTransaction";
  static String type = "type";
  static String description = "description";
  static String accountId = "accountId";
  static String value = "value";
  static String date = "date";
  static String moreDesc = "moreDesc";
  static String isFixed = "isFixed";
  static String isRepeatable = "isRepeatable";

  static String tableName = "transactions";
}

/// Model de transação
///
/// O id nunca deve ser inserido, somente recuperado
///
/// O tipo varia entre: 1 = receita, 2 = despesa, 3 = transferência
///
/// O valor, em caso de despesa, deve ser guardado negativo
///
/// Datas devem ser guardadas como string, e transformadas de volta usando formatação de data.
class Transaction {
  int? idTransaction;
  int? type;
  String? description;
  int? accountId;
  double? value;
  String? date;
  String? moreDesc;
  bool isFixed;
  bool isRepeatable;

  Transaction(
      {this.type,
      this.description,
      this.accountId,
      this.value,
      this.date,
      this.moreDesc,
      this.isFixed = false,
      this.isRepeatable = false});

  Transaction.fromMap(Map<String, dynamic> map)
      : idTransaction = map[TransactionForDb.idTransaction],
        type = map[TransactionForDb.type],
        description = map[TransactionForDb.description],
        accountId = map[TransactionForDb.accountId],
        value = map[TransactionForDb.value],
        date = map[TransactionForDb.date],
        moreDesc = map[TransactionForDb.moreDesc],
        isFixed = map[TransactionForDb.isFixed] == 0 ? false : true,
        isRepeatable = map[TransactionForDb.isRepeatable] == 0 ? false : true;

  /// Retorna todos os dados da transação
  Map<String, dynamic> toMap() {
    return {
      TransactionForDb.idTransaction: idTransaction,
      TransactionForDb.type: type,
      TransactionForDb.description: description,
      TransactionForDb.accountId: accountId,
      TransactionForDb.value: value,
      TransactionForDb.date: date,
      TransactionForDb.moreDesc: moreDesc,
      TransactionForDb.isFixed: isFixed ? 1 : 0,
      TransactionForDb.isRepeatable: isRepeatable ? 1 : 0
    };
  }
}
