import 'package:tc/models/account.dart';

class Transaction {
  int? idTransaction;
  String? type;
  String? description;
  Account? account; //TODO: Pegar só o id da conta, não tudo
  double? value;
  DateTime? date;
  String? moreDesc;
  String? category;
  bool isFixed;
  bool isRepeatable;

  Transaction(
      {this.idTransaction,
      this.type,
      this.description,
      this.account,
      this.value,
      this.date,
      this.moreDesc,
      this.category,
      this.isFixed = false,
      this.isRepeatable = false});

  Transaction.fromMap(Map<String, dynamic> map)
      : idTransaction = map["idTransaction"],
        type = map["type"],
        description = map["description"],
        account = map["account"],
        value = map["value"],
        date = map["date"],
        moreDesc = map["moreDesc"],
        category = map["category"],
        isFixed = map["isFixed"],
        isRepeatable = map["isRepeatable"];

  /// Retorna todos os dados da transação
  Map<String, Object?> toMap() {
    return {
      "id": idTransaction,
      "type": type,
      "description": description,
      "account": account,
      "value": value,
      "date": date,
      "moreDesc": moreDesc,
      "category": category,
      "isFixed": isFixed,
      "isRepeatable": isRepeatable
    };
  }
}
