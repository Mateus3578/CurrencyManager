import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';

class ExampleCardGraphs extends StatelessWidget {
  final ThemeProvider theme;

  /// Temporário, apenas para visualização. Cada gráfico terá seu arquivo
  const ExampleCardGraphs({required this.theme});

  @override
  Widget build(BuildContext context) {
    // Não tirar o container de dentro do container pq buga
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.primaryColor,
        ),
        child: Center(
          child: Text(
            "Em Breve",
            style: TextStyle(
              color: theme.iconColor,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
