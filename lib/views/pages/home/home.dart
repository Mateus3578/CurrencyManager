import 'package:flutter/material.dart';
import 'package:tc/classes/app_colors.dart';
import 'package:tc/views/pages/home/widgets/bottom_menu.dart';
import 'package:tc/views/pages/home/widgets/card_money.dart';
import 'package:tc/views/pages/home/widgets/dots_graphs.dart';
import 'package:tc/views/pages/home/widgets/graph_view.dart';
import 'package:tc/views/pages/home/widgets/my_appbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppColors appColors = AppColors.instance;

  late bool _showMoney = false; // Mostra/Oculta o saldo, padrão não mostrar
  late int _index = 0; // Contador de página dos gráficos. Começa no primeiro
  late double _yPosition = 0; // Cuida da posição vertical dos gráficos.
  // Tanto faz o valor, ele muda depois.
  // Só pro Flutter não reclamar que não foi inicializado ¯\_(ツ)_/¯

  @override
  Widget build(BuildContext context) {
    // Mantém a barra de notificações e serve de parâmetro de altura dos widgets
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: appColors.colors["background"],
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // Card de saudações com o nome do usuário. Ao clicar mostra o saldo
          MyAppBar(
            showMoney: _showMoney,
            onClick: () {
              setState(
                () {
                  _showMoney = !_showMoney;
                  _yPosition =
                      _showMoney ? _screenHeight * 0.40 : _screenHeight * 0.20;
                },
              );
            },
          ),
          // Card ocultável com o saldo e receitas/despesas
          CardMoney(
            top: _screenHeight * 0.20,
            showMoney: _showMoney,
          ),
          // Cards de gráficos
          GraphView(
            top: !_showMoney ? _screenHeight * 0.20 : _screenHeight * 0.40,
            changed: (index) {
              setState(
                () {
                  _index = index;
                },
              );
            },
            // A mágica de puxar os gráficos pra cima ou pra baixo e mostrar o saldo
            pan: (details) {
              double positionTopLimit = _screenHeight * 0.20; //Posição inicial
              double positionBottomLimit = _screenHeight * 0.40; //Posição final
              double midlePosition = (positionBottomLimit - positionTopLimit) /
                  2; //Posição do meio

              setState(
                () {
                  // Acompanha a altura do widget
                  _yPosition += details.delta.dy;

                  // Não deixa bugar e subir demais
                  _yPosition = _yPosition < positionTopLimit
                      ? positionTopLimit
                      : _yPosition;

                  // Não deixa bugar e descer demais
                  _yPosition = _yPosition > positionBottomLimit
                      ? positionBottomLimit
                      : _yPosition;

                  // Se chegar no meio já conta que desceu, o mesmo pra subir
                  if (_yPosition != positionBottomLimit &&
                      details.delta.dy > 0) {
                    _yPosition =
                        _yPosition > positionTopLimit + midlePosition - 50
                            ? positionBottomLimit
                            : _yPosition;
                  }
                  if (_yPosition != positionTopLimit && details.delta.dy < 0) {
                    _yPosition =
                        _yPosition < positionBottomLimit - midlePosition
                            ? positionTopLimit
                            : _yPosition;
                  }

                  // Valida que é para mostrar ou não o saldo
                  if (_yPosition == positionBottomLimit) {
                    _showMoney = true;
                  } else if (_yPosition == positionTopLimit) {
                    _showMoney = false;
                  }
                },
              );
            },
          ),
          // Índice dos cards de gráficos
          DotsGraphs(
            index: _index,
            top: !_showMoney ? _screenHeight * 0.60 : _screenHeight * 0.80,
          ),
          // Barra de menu
          BottomMenu(),
        ],
      ),
    );
  }
}
