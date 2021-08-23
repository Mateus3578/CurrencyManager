import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionViewAppbar extends StatelessWidget {
  final onPressedNext;
  final onPressedPrevious;

  /// Quantidade de transações
  final String transactionsCount;

  /// Balanço mensal. Calcular antes de enviar
  final double monthBalance;
  final String currentMonth;
  final Color textColor;

  TransactionViewAppbar({
    required this.transactionsCount,
    required this.monthBalance,
    required this.currentMonth,
    required this.textColor,
    required this.onPressedNext,
    required this.onPressedPrevious,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String formattedValue = NumberFormat.currency(decimalDigits: 2, symbol: "")
        .format(monthBalance);
    return Positioned(
      left: 0,
      top: height * 0.07,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, height * 0.020),
                  child: Text(
                    "Transações",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    splashRadius: 25,
                    icon: Icon(Icons.arrow_back_ios_rounded, color: textColor),
                    onPressed: onPressedPrevious),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    currentMonth,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor),
                  ),
                ),
                IconButton(
                    splashRadius: 25,
                    icon:
                        Icon(Icons.arrow_forward_ios_rounded, color: textColor),
                    onPressed: onPressedNext),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total de transações",
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        transactionsCount,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Balanço mensal",
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "R\$ $formattedValue",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: textColor.withAlpha(50)),
          ],
        ),
      ),
    );
  }
}
