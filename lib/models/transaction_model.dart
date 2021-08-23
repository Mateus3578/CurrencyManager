import 'package:tc/models/DAO/transaction_DAO.dart';

class TransactionModel {
  int? idTransaction;
  final int type;
  final String description;
  final int? accountId;
  final double? value;
  final String date;
  final String? moreDesc;
  final bool isFixed;
  final bool isRepeatable;

  /// Model de transação
  ///
  /// O id nunca deve ser inserido, somente recuperado
  ///
  /// O tipo varia entre: 1 = receita, 2 = despesa, 3 = transferência
  ///
  /// O valor, em caso de despesa, deve ser guardado negativo
  ///
  /// Datas devem ser guardadas como string, e transformadas de volta usando formatação de data.
  TransactionModel({
    required this.type,
    required this.description,
    required this.accountId,
    required this.value,
    required this.date,
    this.moreDesc,
    this.isFixed = false,
    this.isRepeatable = false,
  });

  TransactionModel.fromMap(Map<String, dynamic> map)
      : idTransaction = map[TransactionModelForDb.idTransaction],
        type = map[TransactionModelForDb.type],
        description = map[TransactionModelForDb.description],
        accountId = map[TransactionModelForDb.accountId],
        value = map[TransactionModelForDb.value],
        date = map[TransactionModelForDb.date],
        moreDesc = map[TransactionModelForDb.moreDesc],
        isFixed = map[TransactionModelForDb.isFixed] == 0 ? false : true,
        isRepeatable =
            map[TransactionModelForDb.isRepeatable] == 0 ? false : true;

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
