import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/views/pages/cards/cripto_currency_card.dart';
import 'package:currency_manager/views/pages/cards/currency_card.dart';
import 'package:currency_manager/views/pages/cards/example_card.dart';
import 'package:currency_manager/views/pages/cards/month_balance_graph.dart';

/// Cards com os gráficos
class CustomCardView extends StatelessWidget {
  // Recebe a posição (altura)
  final double top;
  // Recebe o índice do card (página)
  final ValueChanged<int> index;
  // Recebe o evento de arrastar pra cima/baixo
  final GestureDragUpdateCallback pan;
  final ThemeProvider theme;
  final MoneyProvider money;
  const CustomCardView({
    required this.top,
    required this.index,
    required this.pan,
    required this.theme,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: top,
      height: MediaQuery.of(context).size.height * 0.40,
      left: 0,
      right: 0,
      child: GestureDetector(
        onPanUpdate: pan,
        child: PageView(
          onPageChanged: index,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            // Lembrar de atualizar o índice, ou deixar isso automático
            MonthBalanceGraphs(theme: theme, money: money),
            CurrencyCard(theme: theme),
            CriptoCurrencyCard(theme: theme),
            ExampleCard(theme: theme),
          ],
        ),
      ),
    );
  }
}
/*
TODO: Ideias de gráficos

Timeline com a frequência de gastos. Semana, Mês e Ano
Percentual gasto/lucro
Indicadores (API)(Com data): Salário mínimo, CDI, SELIC;
Gráficos baseados em tags

Notícias?

*/