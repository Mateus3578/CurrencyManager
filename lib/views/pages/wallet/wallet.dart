import 'package:flutter/material.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/pages/wallet/widgets/wallet_appbar.dart';
import 'package:tc/views/pages/wallet/widgets/wallet_list.dart';

class Wallet extends StatefulWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  Wallet({required this.theme, required this.money});

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  AccountDAO accountDAO = AccountDAO();
  TransactionDAO transactionDAO = TransactionDAO();

  List<AccountModel> accounts = [];
  List<TransactionModel> transactions = [];
  bool isLoading = false;
  bool allLoaded = false;
  final ScrollController _scrollController = ScrollController();

  /// Busca os dados e coloca na lista
  fetchingData() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    List<AccountModel> dataAccounts = await accountDAO.getAllAccounts();
    if (dataAccounts.isNotEmpty) {
      accounts = dataAccounts;
    }
    //TODO: trocar para mensal
    List<TransactionModel> dataTransactions =
        await transactionDAO.getAllTransactions();
    if (dataTransactions.isNotEmpty) {
      transactions = dataTransactions;
    }

    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        isLoading = false;
        allLoaded = dataAccounts.isEmpty && dataTransactions.isEmpty;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  // ScrollController
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  double _getBalance(List<TransactionModel> list) {
    double balance = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].type == 1) {
        balance += list[i].value!;
      } else if (list[i].type == 2) {
        balance -= list[i].value!;
      }
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        WalletAppbar(
          textColor: widget.theme.textColor,
          monthBalance: _getBalance(transactions),
          currentBalance: widget.money.balance,
        ),
        WalletList(
          accounts: accounts,
          scrollController: _scrollController,
          theme: widget.theme,
          isLoading: isLoading,
        )
      ],
    );
  }
}
