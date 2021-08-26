import 'package:flutter/material.dart';
import 'package:currency_manager/views/custom/custom_animated_bounce.dart';

class HomeAppBar extends StatelessWidget {
  final bool showBalance; // Mostra ou não o saldo
  final VoidCallback onClick; // Recebe o evento de clique no ícone
  final Color iconColor;
  final String userName;

  /// Barra de saudações. Ao clicar, mostra o saldo
  const HomeAppBar({
    required this.showBalance,
    required this.onClick,
    required this.iconColor,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    String username = userName.isNotEmpty ? userName : "usuário";

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
                CustomAnimatedBounce(
                  delay: Duration(seconds: 10),
                  child: Icon(
                    !showBalance ? Icons.expand_more : Icons.expand_less,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
