import 'package:tc/model/account.dart';

class Transaction {
  final int idTransaction;
  final String type;
  final String description;
  final String? moreDesc;
  final Account account;
  final double value;
  final String? category;
  final int? isFixed;
  final int? isAdded;

  Transaction(
      {required this.idTransaction,
      required this.type,
      required this.description,
      required this.account,
      required this.value,
      this.moreDesc,
      this.category,
      this.isFixed,
      this.isAdded});

  Transaction.fromMap(Map<String, dynamic> resource)
      : idTransaction = resource["idTransaction"],
        type = resource["type"],
        description = resource["description"],
        moreDesc = resource["moreDesc"],
        account = resource["account"],
        value = resource["value"],
        category = resource["category"],
        isFixed = resource["isFixed"],
        isAdded = resource["isAdded"];

  /// Retorna todos os dados da transação
  Map<String, Object?> toMap() {
    return {
      "id": idTransaction,
      "type": type,
      "description": description,
      "moreDesc": moreDesc,
      "account": account,
      "value": value,
      "category": category,
      "isFixed": isFixed,
      "isAdded": isAdded
    };
  }
}
