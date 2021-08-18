import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
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

  /// Busca o saldo no db
  _getInformation() async {
    AccountDAO accountDAO = AccountDAO();
    TransactionDAO transactionDAO = TransactionDAO();
    double tempCurrentBalance = 0;
    double tempCurrentRevenues = 0;
    double tempCurrentExpenses = 0;

    List<AccountModel> dataAccount = await accountDAO.getAllAccounts();
    if (dataAccount.isNotEmpty) {
      for (int i = 0; i < dataAccount.length; i++) {
        tempCurrentBalance += dataAccount[i].balance!;
      }
    }

    //TODO: trocar para pegar do mes
    List<TransactionModel> dataTransaction =
        await transactionDAO.getAllTransactions();
    if (dataTransaction.isNotEmpty) {
      for (int i = 0; i < dataTransaction.length; i++) {
        if (dataTransaction[i].type == 1) {
          tempCurrentRevenues += dataTransaction[i].value!;
        } else if (dataTransaction[i].type == 2) {
          tempCurrentExpenses += dataTransaction[i].value!;
        }
      }
    }

    setState(() {
      currentBalance = tempCurrentBalance;
      currentRevenues = tempCurrentRevenues;
      currentExpenses = tempCurrentExpenses;
    });
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
