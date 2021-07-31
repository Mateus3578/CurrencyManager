import 'package:flutter/material.dart';

// Temporário, apenas para visualização. Cada gráfico terá sua classe
// TODO: Criar os cards de gráficos usando esse como preset
class ExampleCardGraphs extends StatelessWidget {
  final Color backgroundColor;
  const ExampleCardGraphs({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
      ),
    );
  }
}
