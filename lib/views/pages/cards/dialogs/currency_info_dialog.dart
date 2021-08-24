import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_manager/models/quotation_model.dart';

Future<void> getCurrencyInfoDialog(
  BuildContext context,
  QuotationModel quotation,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        quotation.code + "->" + quotation.codeConverted,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                quotation.name.substring(
                      0,
                      quotation.name.indexOf("/"),
                    ) +
                    "\n" +
                    quotation.name.substring(
                      quotation.name.indexOf("/") + 1,
                      quotation.name.length,
                    ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Preço de compra:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    NumberFormat.simpleCurrency(locale: "pt-br")
                        .format(double.tryParse(quotation.bid)),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Preço de venda:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    NumberFormat.simpleCurrency(locale: "pt-br")
                        .format(double.tryParse(quotation.ask)),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Variação:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    (double.tryParse(quotation.varBid)! > 0 ? "+" : "") +
                        quotation.varBid +
                        " (" +
                        (double.tryParse(quotation.pctChange)! > 0 ? "+" : "") +
                        quotation.pctChange +
                        "%)",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    "Última Atualização:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    DateFormat("dd/MM/yyyy HH:mm:ss").format(
                      DateFormat("yy-MM-dd hh:mm:ss")
                          .parse(quotation.lastChange),
                    ),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: TextButton(
                child: Text(
                  "Voltar",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
