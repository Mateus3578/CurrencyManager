import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/pages/home/transactions/transaction_list.dart';
import 'package:tc/views/pages/home/transactions/transaction_view_appbar.dart';

// TODO: Puxar pra baixo pra recarregar

class TransactionsView extends StatefulWidget {
  final ThemeProvider theme;
  TransactionsView(this.theme);

  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  TransactionDAO transactionDAO = TransactionDAO();
  List<TransactionModel> items = [];
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

    List<TransactionModel> data = await transactionDAO.getAllTransactions();
    if (data.isNotEmpty) {
      items = data;
    }
    Future.delayed(
      Duration(milliseconds: 250),
      () {
        setState(() {
          isLoading = false;
          allLoaded = data.isEmpty;
        });
      },
    );
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
      balance += list[i].value!;
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        TransactionViewAppbar(
          textColor: widget.theme.textColor,
          transactionsCount: "${items.length}",
          monthBalance: _getBalance(items),
        ),
        TransactionList(
          primaryColor: widget.theme.primaryColor,
          textColor: widget.theme.textColor,
          items: items,
          scrollController: _scrollController,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
