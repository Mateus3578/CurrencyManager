import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/transactions/options/widgets/dialogs/new_account_dialog.dart';

class WalletAppbar extends StatelessWidget {
  final onPressedNext;
  final onPressedPrevious;

  final double monthBalance;
  final String currentMonth;
  final ThemeProvider theme;
  final MoneyProvider moneyProvider;
  WalletAppbar({
    required this.theme,
    required this.monthBalance,
    required this.currentMonth,
    required this.moneyProvider,
    required this.onPressedNext,
    required this.onPressedPrevious,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String formattedcurrentBalance =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
            .format(moneyProvider.balance);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, height * 0.02),
                  child: Text(
                    "Contas",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: theme.textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: GestureDetector(
                      onTap: () => getNewAccountDialog(
                        context: context,
                        moneyProvider: moneyProvider,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.alterColor,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 25,
                          color: theme.iconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: theme.textColor),
                  onPressed: onPressedPrevious,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    currentMonth,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: theme.textColor),
                  ),
                ),
                IconButton(
                  splashRadius: 25,
                  icon: Icon(Icons.arrow_forward_ios_rounded,
                      color: theme.textColor),
                  onPressed: onPressedNext,
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
                        style: TextStyle(fontSize: 16, color: theme.textColor),
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
                          color: theme.textColor,
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
                        style: TextStyle(fontSize: 16, color: theme.textColor),
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
                          color: theme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: theme.textColor.withAlpha(50)),
          ],
        ),
      ),
    );
  }
}
