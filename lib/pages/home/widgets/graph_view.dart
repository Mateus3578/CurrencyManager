import 'package:flutter/material.dart';
import 'card_graphs.dart';

class GraphView extends StatelessWidget {
  final double top;
  final ValueChanged<int> changed;
  final GestureDragUpdateCallback pan;

  const GraphView({
    Key? key,
    required this.top,
    required this.changed,
    required this.pan,
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
              onPageChanged: changed,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                CardGraphs(),
                CardGraphs(),
                CardGraphs(),
              ],
            )));
  }
}
