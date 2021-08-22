import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Card com o saldo
class CardMoney extends StatelessWidget {
  final double top;
  final bool showMoney;
  final double currentBalance;
  final double currentRevenues;
  final double currentExpenses;
  final Future<void> Function() onRefresh;

  CardMoney({
    Key? key,
    required this.top,
    required this.showMoney,
    required this.currentBalance,
    required this.currentRevenues,
    required this.currentExpenses,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    String formattedcurrentBalance =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
            .format(currentBalance);
    String formattedcurrentRevenues =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
            .format(currentRevenues);
    String formattedcurrentExpenses =
        NumberFormat.currency(decimalDigits: 2, symbol: "")
            .format(currentExpenses);

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        // Mostra ou não o saldo usando a opacidade
        opacity: showMoney ? 1 : 0,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.24,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Text(
                      "Saldo",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "R\$ $formattedcurrentBalance",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_circle_up_rounded,
                              color: Colors.green,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Receitas",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "R\$ $formattedcurrentRevenues",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Despesas",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "R\$ $formattedcurrentExpenses",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
