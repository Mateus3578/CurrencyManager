import 'package:flutter/material.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/transactions/options/new_card_expense.dart';
import 'package:tc/views/pages/transactions/options/new_common_transaction.dart';
import 'package:tc/views/pages/transactions/options/new_transfer.dart';

class NewTransaction extends StatelessWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  NewTransaction({required this.theme, required this.money});

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(
        width * 0.1,
        height * 0.5,
        width * 0.1,
        height * 0.13,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemOption(
                context,
                Colors.green,
                Icons.arrow_upward_rounded,
                "Receita\n",
                NewCommonTransaction(
                  theme: theme,
                  money: money,
                  type: NewCommonTransaction.revenueType,
                ),
              ),
              itemOption(
                context,
                Colors.red,
                Icons.arrow_downward_rounded,
                "Despesa\n",
                NewCommonTransaction(
                  theme: theme,
                  money: money,
                  type: NewCommonTransaction.expenseType,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemOption(
                context,
                Colors.blue,
                Icons.cached_rounded,
                "Transferência\n",
                NewTransfer(),
              ),
              itemOption(
                context,
                Colors.purple,
                Icons.credit_card_rounded,
                "Despesa\nCartão",
                NewCardExpense(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded itemOption(
    BuildContext context,
    Color color,
    IconData iconData,
    String text,
    builderRoute,
  ) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => builderRoute,
                  ),
                );
              },
              backgroundColor: color,
              child: Icon(
                iconData,
                size: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
