import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletAppbar extends StatelessWidget {
  final Color textColor;
  final double monthBalance;
  final double currentBalance;
  WalletAppbar({
    required this.textColor,
    required this.monthBalance,
    required this.currentBalance,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String formattedcurrentBalance =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
            .format(currentBalance);
    String formattedmonthBalance =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
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
                    "Contas",
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
                  onPressed: () {
                    //TODO: alternar entre os meses
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "Julho",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: textColor),
                  ),
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_forward_ios_rounded, color: textColor),
                  onPressed: () {
                    //TODO: alternar entre os meses
                  },
                ),
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
                        "Saldo atual",
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "R\$ $formattedcurrentBalance",
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
                        "Saldo no mês",
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "R\$ $formattedmonthBalance",
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
