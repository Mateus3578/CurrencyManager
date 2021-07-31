/// Para não errar os nomes
class TransactionModelForDb {
  static String idTransaction = "transactionId";
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
class TransactionModel {
  int? _idTransaction;
  int? type;
  String? description;
  int? accountId;
  double? value;
  String? date;
  String? moreDesc;
  bool isFixed;
  bool isRepeatable;

  TransactionModel(
      {this.type,
      this.description,
      this.accountId,
      this.value,
      this.date,
      this.moreDesc,
      this.isFixed = false,
      this.isRepeatable = false});

  TransactionModel.fromMap(Map<String, dynamic> map)
      : _idTransaction = map[TransactionModelForDb.idTransaction],
        type = map[TransactionModelForDb.type],
        description = map[TransactionModelForDb.description],
        accountId = map[TransactionModelForDb.accountId],
        value = map[TransactionModelForDb.value],
        date = map[TransactionModelForDb.date],
        moreDesc = map[TransactionModelForDb.moreDesc],
        isFixed = map[TransactionModelForDb.isFixed] == 0 ? false : true,
        isRepeatable =
            map[TransactionModelForDb.isRepeatable] == 0 ? false : true;

  /// Retorna todos os dados da transação
  Map<String, dynamic> toMap() {
    return {
      TransactionModelForDb.type: type,
      TransactionModelForDb.description: description,
      TransactionModelForDb.accountId: accountId,
      TransactionModelForDb.value: value,
      TransactionModelForDb.date: date,
      TransactionModelForDb.moreDesc: moreDesc,
      TransactionModelForDb.isFixed: isFixed ? 1 : 0,
      TransactionModelForDb.isRepeatable: isRepeatable ? 1 : 0
    };
  }
}
