import 'package:flutter/material.dart';
import 'package:tc/classes/app_colors.dart';

// Temporário, apenas para visualização. Cada gráfico terá sua classe
// TODO: Criar os cards de gráficos usando esse como preset
class CardGraphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors.instance;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
            color: appColors.colors["main"],
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
