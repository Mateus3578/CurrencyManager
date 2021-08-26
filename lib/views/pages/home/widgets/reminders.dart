import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:flutter/material.dart';

class RemindersView extends StatelessWidget {
  // Recebe a posição (altura)
  final double top;
  final ThemeProvider theme;
  const RemindersView({
    required this.top,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: top,
      height: MediaQuery.of(context).size.height * 0.2,
      left: 0,
      right: 0,
      child: Container(
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
      ),
    );
  }
}
