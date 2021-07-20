import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListTile extends StatelessWidget {
  final onTap;

  /// Descrição da transação
  final String description;

  /// Tipo de transação (despesa, receita etc)
  final int type;

  /// Valor da transação. Formatado aqui mesmo
  final double value;

  const TransactionListTile(
      {Key? key,
      required this.description,
      required this.type,
      required this.value,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _returnIcon(int type) {
      if (type == 1) {
        return Icon(
          Icons.arrow_upward_rounded,
          color: Colors.green,
        );
      }
      if (type == 2) {
        return Icon(
          Icons.arrow_downward_rounded,
          color: Colors.red,
        );
      }
      if (type == 3) {
        return Icon(
          Icons.cached_rounded,
          color: Colors.blue,
        );
      }
      return Icon(Icons.circle_outlined);
    }

    String formattedValue =
        NumberFormat.currency(decimalDigits: 2, symbol: "").format(value);

    return ListTile(
      title: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _returnIcon(type),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(description),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text("R\$ $formattedValue"),
          ),
        ],
      )),
      onTap: onTap,
    );
  }
}
