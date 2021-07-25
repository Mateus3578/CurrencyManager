import 'package:flutter/material.dart';
import 'package:tc/classes/user_preferences.dart';

// Temporário, apenas para visualização. Cada gráfico terá sua classe
// TODO: Criar os cards de gráficos usando esse como preset
class CardGraphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences.instance;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            color: userPreferences.colors["main"],
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
