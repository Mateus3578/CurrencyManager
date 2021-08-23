class QuotationModel {
  /// Código da moeda
  final String code;

  /// Código da moeda em que o valor foi convertido
  final String codeConverted;

  /// Nome por extenso da moeda do code e do codeConverted,
  /// na forma "code/codeConverted"
  final String name;

  /// Variação
  final String varBid;

  /// Porcentagem de Variação
  final String pctChange;

  /// Valor compra
  final String bid;

  /// Valor venda
  final String ask;

  /// Data da última atualização. Formato:"2021-08-20 17:59:56"
  final String lastChange;

  /// Model para a api de cotações
  QuotationModel({
    required this.code,
    required this.codeConverted,
    required this.name,
    required this.varBid,
    required this.pctChange,
    required this.bid,
    required this.ask,
    required this.lastChange,
  });

  factory QuotationModel.fromMap(Map<String, dynamic> map) {
    return QuotationModel(
      code: map["code"],
      codeConverted: map["codein"],
      name: map["name"],
      varBid: map["varBid"],
      pctChange: map["pctChange"],
      bid: map["bid"],
      ask: map["ask"],
      lastChange: map["create_date"],
    );
  }
}
