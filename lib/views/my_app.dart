import 'package:flutter/material.dart';
import 'package:tc/views/pages/home/home.dart';
import 'package:tc/views/pages/home/transactions/monthly_transactions.dart';
import 'package:tc/views/pages/home/widgets/bottom_menu.dart';
import 'package:tc/views/pages/settings/settings.dart';
import 'package:tc/classes/user_preferences.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserPreferences userPreferences = UserPreferences.instance;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userPreferences.colors["background"],
      body: _body(pageIndex),
      bottomNavigationBar: BottomMenu(
        onPressed: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }

  Widget _body(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return Home(); // TODO: Mudar para carteira
      case 2:
        return MonthlyTransactions();
      case 3:
        return Settings();
      default:
        return Home();
    }
  }
}
