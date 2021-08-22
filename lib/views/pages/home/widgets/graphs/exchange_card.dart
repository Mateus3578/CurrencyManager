import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tc/controllers/theme_provider.dart';

class ExchangeCard extends StatefulWidget {
  final ThemeProvider theme;
  ExchangeCard({required this.theme});

  @override
  _ExchangeCardState createState() => _ExchangeCardState();
}

class _ExchangeCardState extends State<ExchangeCard> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _getData();
  }

  //TODO: Adicionar opções de mais moedas
  //Conexão com a api
  Future<List<Data>> _getData() async {
    http.Response response;
    response = await http.get(Uri.parse(
      "https://economia.awesomeapi.com.br/last/USD-BRL,USD-BRLT,EUR-BRL,GBP-BRL,ARS-BRL,JPY-BRL",
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List<Data> data = [];
      result.forEach((key, value) {
        data.add(Data.fromMap(value));
      });

      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Não tirar o container de dentro do container pq buga
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.theme.primaryColor,
        ),
        child: FutureBuilder<List<Data>>(
          future: _getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: widget.theme.alterColor,
                    ),
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados.",
                      style: TextStyle(
                        color: widget.theme.iconColor,
                        fontSize: 20,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: RefreshIndicator(
                      onRefresh: _getData,
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification:
                            (OverscrollIndicatorNotification overscroll) {
                          overscroll.disallowGlow();
                          return false;
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: snapshot.data!.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data![index].code +
                                        "->" +
                                        snapshot.data![index].codeConverted,
                                    style: TextStyle(
                                      color: widget.theme.iconColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        NumberFormat.simpleCurrency(
                                                locale: "pt-br")
                                            .format(double.tryParse(
                                                snapshot.data![index].bid)),
                                        style: TextStyle(
                                          color: widget.theme.iconColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "(" +
                                            (double.tryParse(snapshot
                                                        .data![index]
                                                        .pctChange)! >
                                                    0
                                                ? "+"
                                                : "") +
                                            snapshot.data![index].pctChange +
                                            "%)",
                                        style: TextStyle(
                                          color: widget.theme.iconColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

// TODO: Opção para mais informações ao clicar no item da lista.
// Usar todos os dados.
///https://docs.awesomeapi.com.br/api-de-moedas
class Data {
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

  /// Data da última atualização
  final String timestamp;

  Data({
    required this.code,
    required this.codeConverted,
    required this.name,
    required this.varBid,
    required this.pctChange,
    required this.bid,
    required this.ask,
    required this.timestamp,
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      code: map["code"],
      codeConverted: map["codein"],
      name: map["name"],
      varBid: map["varBid"],
      pctChange: map["pctChange"],
      bid: map["bid"],
      ask: map["ask"],
      timestamp: map["timestamp"],
    );
  }
}
