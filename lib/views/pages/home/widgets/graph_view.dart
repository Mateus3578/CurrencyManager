import 'package:flutter/material.dart';
import 'graphs/example_card_graph.dart';

/// "Deck" de cards com os gráficos
class GraphView extends StatelessWidget {
  // Recebe a posição (altura)
  final double top;
  // Recebe o índice do card (página)
  final ValueChanged<int> index;
  // Recebe o evento de arrastar pra cima/baixo
  final GestureDragUpdateCallback pan;
  final Color backgroundColor;
  const GraphView({
    Key? key,
    required this.top,
    required this.index,
    required this.pan,
    required this.backgroundColor,
  }) : super(key: key);

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
            ExampleCardGraphs(backgroundColor: backgroundColor),
            ExampleCardGraphs(backgroundColor: backgroundColor),
            ExampleCardGraphs(backgroundColor: backgroundColor),
          ],
        ),
      ),
    );
  }
}
