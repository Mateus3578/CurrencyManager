import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListAppbar extends StatelessWidget {
  /// Quantidade de transações
  final String transactions;

  /// Balanço mensal. Calcular antes de enviar
  final double monthBalance;

  const TransactionListAppbar(
      {Key? key, required this.transactions, required this.monthBalance})
      : super(key: key);

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
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "Julho",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(20, height * 0.02, 0, height * 0.005),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total de transações",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        transactions,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(0, height * 0.02, 20, height * 0.005),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Balanço mensal",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "R\$ $formattedValue",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
