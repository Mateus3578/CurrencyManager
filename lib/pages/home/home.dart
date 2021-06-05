import 'package:flutter/material.dart';
import 'package:tc/pages/home/widgets/card_money.dart';
import 'package:tc/pages/home/widgets/dots_graphs.dart';
import 'package:tc/pages/home/widgets/graph_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late bool _showMoney;
  late int _index;
  late double _yPosition;

  @override
  void initState() {
    super.initState();
    _showMoney = false;
    _index = 0;
    _yPosition = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    if (_yPosition == 0) {
      _yPosition = _screenHeight * 0.24;
    }

    return Scaffold(
      extendBody: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          CardMoney(
            showMoney: _showMoney,
            click: () {
              setState(() {
                _showMoney = !_showMoney;
                _yPosition =
                    _showMoney ? _screenHeight * 0.44 : _screenHeight * 0.24;
              });
            },
          ),
          GraphView(
            top: !_showMoney ? _screenHeight * 0.24 : _screenHeight * 0.44,
            changed: (index) {
              setState(() {
                _index = index;
              });
            },
            pan: (details) {
              double positionBottomLimit = _screenHeight * 0.44;
              double positionTopLimit = _screenHeight * 0.24;
              double midlePosition = positionBottomLimit - positionTopLimit;
              midlePosition = midlePosition / 2;
              setState(() {
                _yPosition += details.delta.dy;

                _yPosition = _yPosition < positionTopLimit
                    ? positionTopLimit
                    : _yPosition;

                _yPosition = _yPosition > positionBottomLimit
                    ? positionBottomLimit
                    : _yPosition;

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
            top: !_showMoney ? _screenHeight * 0.65 : _screenHeight * 0.85,
          ),
        ],
      ),
    );
  }
}
