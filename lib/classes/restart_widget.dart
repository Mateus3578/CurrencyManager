import 'package:flutter/material.dart';

/// Reinicia o app. Útil para aplicar as mudanças de cores.
///
/// Basicamente, o app inteiro fica dentro de um stateful que é recarregado ao chamar o método restartApp, recriando tudo com um novo identificador (key).
///
/// O app não é realmente reiniciado (A nível do sistema), ou seja, o app não para de rodar ou fecha e abre de novo, simplesmente reseta e recria as telas.
///
/// https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
