import 'package:currency_manager/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_manager/controllers/theme_provider.dart';

class TransactionListTile extends StatelessWidget {
  final onTap;
  final onLongPress;
  final ThemeProvider theme;
  final TransactionModel transaction;

  const TransactionListTile({
    required this.transaction,
    required this.onTap,
    required this.onLongPress,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.parse(transaction.date);

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

    String formattedValue = NumberFormat.currency(decimalDigits: 2, symbol: "")
        .format(transaction.value);

    return ListTile(
      title: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                _returnIcon(transaction.type),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      transaction.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Text(
                  "R\$ $formattedValue",
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "${DateFormat("EEEE, dd", "pt_BR").format(_date)}",
                  maxLines: 1,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      )),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
