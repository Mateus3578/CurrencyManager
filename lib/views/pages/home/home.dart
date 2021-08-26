import 'package:currency_manager/views/pages/home/widgets/reminders.dart';
import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/views/pages/home/widgets/card_balance.dart';
import 'package:currency_manager/views/pages/home/widgets/graph_dots.dart';
import 'package:currency_manager/views/pages/home/widgets/custom_card_view.dart';
import 'package:currency_manager/views/pages/home/widgets/home_appbar.dart';

class Home extends StatefulWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  Home({required this.theme, required this.money});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Mostra/Oculta o saldo, padrão não mostrar
  late bool _showBalance = false;
  // Contador de página dos gráficos. Começa no primeiro
  late int _graphIndex = 0;
  // Cuida da posição vertical dos gráficos.
  // Tanto faz o valor, ele muda depois.
  // Só pra não reclamar que não foi inicializado ¯\_(ツ)_/¯
  late double _yPosition = 0;

  @override
  Widget build(BuildContext context) {
    // Parâmetro de altura dos widgets
    double _screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        // Card de saudações com o nome do usuário. Ao clicar mostra o saldo
        HomeAppBar(
          userName: widget.theme.username,
          showBalance: _showBalance,
          iconColor: widget.theme.textColor,
          onClick: () {
            setState(
              () {
                _showBalance = !_showBalance;
                _yPosition =
                    _showBalance ? _screenHeight * 0.35 : _screenHeight * 0.15;
              },
            );
          },
        ),
        // Card ocultável com o saldo e receitas/despesas
        CardBalance(
          top: _screenHeight * 0.15,
          showMoney: _showBalance,
          currentBalance: widget.money.balance,
          currentExpenses: widget.money.expenses,
          currentRevenues: widget.money.revenues,
          onRefresh: () async {
            widget.money.fetchData();
          },
        ),
        // Cards de gráficos
        CustomCardView(
          top: !_showBalance ? _screenHeight * 0.15 : _screenHeight * 0.35,
          theme: widget.theme,
          money: widget.money,
          index: (index) {
            setState(
              () {
                _graphIndex = index;
              },
            );
          },
          // A mágica de puxar os gráficos pra cima ou pra baixo e mostrar o saldo
          pan: (details) {
            double topLimit = _screenHeight * 0.15; //Posição inicial
            double bottomLimit = _screenHeight * 0.35; //Posição final
            double midlePosition =
                (bottomLimit - topLimit) / 2; //Posição do meio

            setState(
              () {
                // Acompanha a altura do widget
                _yPosition += details.delta.dy;

                // Não deixa bugar e subir demais
                _yPosition = _yPosition < topLimit ? topLimit : _yPosition;

                // Não deixa bugar e descer demais
                _yPosition =
                    _yPosition > bottomLimit ? bottomLimit : _yPosition;

                // Se chegar no meio já conta que desceu, o mesmo pra subir
                if (_yPosition != bottomLimit && details.delta.dy > 0) {
                  _yPosition = _yPosition > topLimit + midlePosition - 50
                      ? bottomLimit
                      : _yPosition;
                }
                if (_yPosition != topLimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < bottomLimit - midlePosition
                      ? topLimit
                      : _yPosition;
                }

                // Valida que é para mostrar ou não o saldo
                if (_yPosition == bottomLimit) {
                  _showBalance = true;
                } else if (_yPosition == topLimit) {
                  _showBalance = false;
                }
              },
            );
          },
        ),
        // Índice dos cards de gráficos
        GraphDots(
          index: _graphIndex,
          color: widget.theme.textColor,
          top: !_showBalance ? _screenHeight * 0.55 : _screenHeight * 0.75,
        ),
        // Lembretes
        RemindersView(
          top: !_showBalance ? _screenHeight * 0.6 : _screenHeight * 0.8,
          theme: widget.theme,
        ),
      ],
    );
  }
}
