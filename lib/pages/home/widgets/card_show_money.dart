import 'package:flutter/material.dart';

class CardShowMoney extends StatelessWidget {
  final bool showMoney; // Mostra ou não o saldo
  final VoidCallback click; // Recebe o evento de clique no ícone

  const CardShowMoney({Key? key, required this.showMoney, required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        GestureDetector(
          onTap: click,
          child: Container(
            color: Colors.red,
            height: MediaQuery.of(context).size.height * 0.14,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Detalhes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Icon(
                  !showMoney ? Icons.expand_more : Icons.expand_less,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
