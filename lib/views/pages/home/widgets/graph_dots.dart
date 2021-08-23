import 'package:flutter/material.dart';

class GraphDots extends StatelessWidget {
  final int index; // Recebe o índice do card (página)
  final double top; // Recebe a posição (altura)
  final Color color;

  /// Bolinhas (dots) que representam a página dos gráficos
  const GraphDots({
    required this.index,
    required this.top,
    required this.color,
  });

  /// Deixa em destaque (cor) apenas o dot do índice atual
  Color? getColor(int dotIndex) {
    return index == dotIndex ? color : color.withOpacity(0.38);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: top,
      child: Row(
        children: <Widget>[
          dotContainer(0),
          SizedBox(width: 8),
          dotContainer(1),
          SizedBox(width: 8),
          dotContainer(2),
          SizedBox(width: 8),
          dotContainer(3),
        ],
      ),
    );
  }

  AnimatedContainer dotContainer(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 7,
      width: 7,
      decoration: BoxDecoration(
        color: getColor(index),
        shape: BoxShape.circle,
      ),
    );
  }
}
