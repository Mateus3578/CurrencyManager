import 'package:flutter/material.dart';
import 'package:tc/pages/home/widgets/card_money.dart';
import 'package:tc/pages/home/widgets/card_show_money.dart';
import 'package:tc/pages/home/widgets/dots_graphs.dart';
import 'package:tc/pages/home/widgets/graph_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _showMoney; // Mostra/Oculta o saldo
  late int _index; // Contador de página dos gráficos
  late double _yPosition; // Cuida da posição dos gráficos

  @override
  void initState() {
    super.initState();
    _showMoney = false;
    _index = 0;
    _yPosition = 0;
  } // Inicia tudo com 0 fds

  @override
  Widget build(BuildContext context) {
    // Mantém a barra de notificações e serve de parâmetro de altura dos widgets
    double _screenHeight = MediaQuery.of(context).size.height;

    // Isso que da inicializar tudo com 0
    if (_yPosition == 0) {
      _yPosition = _screenHeight * 0.24;
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          CardShowMoney(
            showMoney: _showMoney,
            click: () {
              setState(() {
                // Posição levando em conta o card de saldo
                _showMoney = !_showMoney;
                _yPosition =
                    _showMoney ? _screenHeight * 0.44 : _screenHeight * 0.24;
              });
            },
          ),
          CardMoney(
            top: _screenHeight * 0.20,
            showMoney: _showMoney,
          ),
          GraphView(
            // Posição levando em conta o card de saldo
            top: !_showMoney ? _screenHeight * 0.24 : _screenHeight * 0.44,
            changed: (index) {
              setState(() {
                _index = index;
              });
            },
            // A mágica de puxar os gráficos pra cima ou pra baixo e mostrar o saldo
            pan: (details) {
              double positionTopLimit = _screenHeight * 0.24; //Posição inicial
              double positionBottomLimit = _screenHeight * 0.44; //Posição final
              double midlePosition = (positionBottomLimit - positionTopLimit) /
                  2; //Posição do meio

              setState(() {
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
                if (_yPosition != positionBottomLimit && details.delta.dy > 0) {
                  _yPosition =
                      _yPosition > positionTopLimit + midlePosition - 50
                          ? positionBottomLimit
                          : _yPosition;
                }
                if (_yPosition != positionTopLimit && details.delta.dy < 0) {
                  _yPosition = _yPosition < positionBottomLimit - midlePosition
                      ? positionTopLimit
                      : _yPosition;
                }

                // Valida que é para mostrar ou não o saldo
                if (_yPosition == positionBottomLimit) {
                  _showMoney = true;
                } else if (_yPosition == positionTopLimit) {
                  _showMoney = false;
                }
              });
            },
          ),
          DotsGraphs(
            index: _index,
            // Posição levando em conta o card de saldo
            top: !_showMoney ? _screenHeight * 0.65 : _screenHeight * 0.85,
          ),
        ],
      ),
    );
  }
}
