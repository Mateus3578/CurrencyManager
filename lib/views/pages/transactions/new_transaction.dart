import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/transactions/options/new_revenue.dart';

class NewTransaction extends StatefulWidget {
  final ThemeProvider theme;
  NewTransaction(this.theme);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @override
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
                Colors.green,
                Icons.arrow_upward_rounded,
                "Receita\n",
                NewRevenue(widget.theme),
              ),
              itemOption(
                Colors.red,
                Icons.arrow_downward_rounded,
                "Despesa\n",
                NewRevenue(widget.theme),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itemOption(
                Colors.blue,
                Icons.cached_rounded,
                "Transferência\n",
                NewRevenue(widget.theme),
              ),
              itemOption(
                Colors.purple,
                Icons.credit_card_rounded,
                "Despesa\nCartão",
                NewRevenue(widget.theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded itemOption(
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
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
