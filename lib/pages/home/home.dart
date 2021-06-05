import 'package:flutter/material.dart';
import 'package:tc/pages/home/widgets/card_money.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          CardMoney(),
        ],
      ),
    );
  }
}
