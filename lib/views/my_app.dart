import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/home/home.dart';
import 'package:tc/views/pages/home/transactions/transactions_view.dart';
import 'package:tc/views/pages/home/widgets/bottom_menu.dart';
import 'package:tc/views/pages/settings/settings.dart';
import 'package:tc/views/pages/wallet/wallet.dart';

class MyApp extends StatefulWidget {
  final ThemeProvider theme;
  MyApp(this.theme);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Índice para guiar entre as páginas principais. Começa na Home
  int pageIndex = 0;

  double currentBalance = 0;
  double currentRevenues = 0;
  double currentExpenses = 0;

  //TODO: Buscar no db
  /// Busca o saldo no db
  _getInformation() async {
    currentRevenues = 0;
    currentExpenses = 0;

    // Buscar os dados

    currentBalance = currentRevenues - currentExpenses;
  }

  @override
  void initState() {
    super.initState();
    _getInformation();
  }

  @override
  Widget build(BuildContext context) {
    Widget _body(int index) {
      // Decide qual tela mostrar com base no índice
      switch (index) {
        case 0:
          return Home(
            theme: widget.theme,
            currentBalance: currentBalance,
            currentRevenues: currentRevenues,
            currentExpenses: currentExpenses,
          );
        case 1:
          return Wallet(
            theme: widget.theme,
            currentBalance: currentBalance,
          );
        case 2:
          return TransactionsView(widget.theme);
        case 3:
          return Settings(widget.theme);
        default:
          return Home(
            theme: widget.theme,
            currentBalance: currentBalance,
            currentRevenues: currentRevenues,
            currentExpenses: currentExpenses,
          );
      }
    }

    // Os filhos desse widget (praticamente tudo) serão notificados
    // quando o value tema for alterado.
    return ChangeNotifierProvider.value(
      value: widget.theme,
      child: Consumer<ThemeProvider>(
        builder: (context, theme, __) {
          return Scaffold(
            body: _body(pageIndex),
            bottomNavigationBar: BottomMenu(
              theme: widget.theme,
              onPressed: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
