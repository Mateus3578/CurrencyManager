import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc/controllers/api_quotation_helper.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/quotation_model.dart';
import 'package:tc/views/pages/cards/dialogs/currency_info_dialog.dart';

class CurrencyCard extends StatefulWidget {
  final ThemeProvider theme;
  CurrencyCard({required this.theme});

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  late Future<List<QuotationModel>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = _getData();
  }

  //TODO: Adicionar opções de mais ou menos moedas
  // TODO: Mostrar ícone do país
  /// Conexão com a api
  Future<List<QuotationModel>> _getData() async {
    ApiQuotationHelper api = ApiQuotationHelper.instance;
    String url =
        "https://economia.awesomeapi.com.br/last/USD-BRL,USD-BRLT,EUR-BRL,GBP-BRL,ARS-BRL";

    return await api.getData(url);
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Câmbio",
                style: TextStyle(
                  color: widget.theme.iconColor,
                  fontSize: 24,
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder<List<QuotationModel>>(
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
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
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
                                  return GestureDetector(
                                    onTap: () {
                                      getCurrencyInfoDialog(
                                        context,
                                        snapshot.data![index],
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data![index].code +
                                                "->" +
                                                snapshot
                                                    .data![index].codeConverted,
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
                                                        snapshot
                                                            .data![index].bid)),
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
                                                    snapshot.data![index]
                                                        .pctChange +
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
          ],
        ),
      ),
    );
  }
}
