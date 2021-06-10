import 'package:flutter/material.dart';

// Temporário, apenas para visualização. Cada gráfico terá sua classe
class CardGraphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
