import 'package:flutter/material.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/home/widgets/graphs/criptoexchange_card.dart';
import 'package:tc/views/pages/home/widgets/graphs/exchange_card.dart';
import 'package:tc/views/pages/home/widgets/graphs/month_balance_graph.dart';
import 'graphs/example_card_graph.dart';

//TODO: Opção para mostar/esconder card e customizar card

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
            ExchangeCard(theme: theme),
            CriptoExchangeCard(theme: theme),
            ExampleCardGraphs(theme: theme),
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
Câmbio (Valor e variação): Dólar, Euro, Libra, etc
Câmbio criptomoedas (Valor e variação): Bitcoin e cia

Notícias?

*/