import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/home/home.dart';
import 'package:tc/views/pages/home/transactions/transactions_view.dart';
import 'package:tc/views/pages/home/widgets/bottom_menu.dart';
import 'package:tc/views/pages/settings/settings.dart';

class MyApp extends StatefulWidget {
  final ThemeProvider theme;
  MyApp(this.theme);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget _body(int index) {
      switch (index) {
        case 0:
          return Home(widget.theme);
        case 1:
          return Home(widget.theme); // TODO: Mudar para carteira
        case 2:
          return TransactionsView(widget.theme);
        case 3:
          return Settings(widget.theme);
        default:
          return Home(widget.theme);
      }
    }

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
