import 'package:flutter/material.dart';
import 'package:tc/pages/home/classes/navbar_custom_painter.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: size.width,
          height: 80,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: NavbarCustomPainter(Colors.amber),
              ),
              // Botão de adicionar transações
              Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.orange,
                  child: Icon(
                    Icons.add,
                    size: 35,
                  ),
                  elevation: 0.1,
                ),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Menu principal
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.home),
                      color: Colors.black,
                      iconSize: 30,
                    ),
                    // Contas
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.account_balance_wallet),
                      color: Colors.black,
                      iconSize: 30,
                    ),
                    //Espaçamento
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    // Lista de transações
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.list),
                      color: Colors.black,
                      iconSize: 30,
                    ),
                    // Configurações
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                      color: Colors.black,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
