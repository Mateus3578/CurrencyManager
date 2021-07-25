import 'package:flutter/material.dart';
import 'package:tc/classes/user_preferences.dart';

/// Barra de saudações. Ao clicar, mostra o saldo
class MyAppBar extends StatelessWidget {
  final bool showMoney; // Mostra ou não o saldo
  final VoidCallback onClick; // Recebe o evento de clique no ícone

  const MyAppBar({Key? key, required this.showMoney, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences.instance;
    final String username = userPreferences.username;

    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        GestureDetector(
          onTap: onClick,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.14,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Olá, " + "$username",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Detalhes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  !showMoney ? Icons.expand_more : Icons.expand_less,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
