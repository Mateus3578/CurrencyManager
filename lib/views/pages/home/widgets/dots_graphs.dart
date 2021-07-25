import 'package:flutter/material.dart';
import 'package:tc/classes/user_preferences.dart';

/// Bolinhas (dots) que representam a página dos gráficos
///
/// Poderia ter usado um carousel ou algo assim, mas....
class DotsGraphs extends StatelessWidget {
  final int index; // Recebe o índice do card (página)
  final double top; // Recebe a posição (altura)

  /// Deixa em destaque (cor) apenas o dot do índice atual
  Color? getColor(int dotIndex) {
    UserPreferences userPreferences = UserPreferences.instance;
    return index == dotIndex
        ? userPreferences.colors["icon"]
        : userPreferences.colors["icon"]!.withOpacity(0.38);
  }

  const DotsGraphs({Key? key, required this.index, required this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: top,
      child: Row(
        children: <Widget>[
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 7,
            width: 7,
            decoration:
                BoxDecoration(color: getColor(0), shape: BoxShape.circle),
          ),
          SizedBox(
            width: 8,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 7,
            width: 7,
            decoration:
                BoxDecoration(color: getColor(1), shape: BoxShape.circle),
          ),
          SizedBox(
            width: 8,
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: 7,
            width: 7,
            decoration:
                BoxDecoration(color: getColor(2), shape: BoxShape.circle),
          )
        ],
      ),
    );
  }
}
