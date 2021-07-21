import 'package:flutter/material.dart';
import 'package:tc/classes/app_colors.dart';
import 'package:tc/classes/app_database.dart';
import 'package:tc/models/transaction.dart';
import 'package:tc/views/pages/home/transactions/transaction_list.dart';
import 'package:tc/views/pages/home/transactions/transaction_list_appbar.dart';
import 'package:tc/views/pages/home/widgets/bottom_menu.dart';

class MonthlyTransactions extends StatefulWidget {
  const MonthlyTransactions({Key? key}) : super(key: key);

  @override
  _MonthlyTransactionsState createState() => _MonthlyTransactionsState();
}

class _MonthlyTransactionsState extends State<MonthlyTransactions> {
  AppDatabase db = AppDatabase.instance;
  List<Transaction> items = [];
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
    await Future.delayed(Duration(milliseconds: 500));
    //List<Transaction> data = lista;
    List<Transaction> data = await db.getAllTransactions();
    if (data.isNotEmpty) {
      items = data;
    }
    setState(() {
      isLoading = false;
      allLoaded = data.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchingData();
  }

  // Para o scrollController
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  double _getBalance(List<Transaction> list) {
    double balance = 0;
    for (int i = 0; i < list.length; i++) {
      balance += list[i].value!;
    }
    return balance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.colors["background"],
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          TransactionListAppbar(
            transactions: "${items.length}",
            monthBalance: _getBalance(items),
          ),
          TransactionList(
            items: items,
            scrollController: _scrollController,
          ),
          BottomMenu()
        ],
      ),
    );
  }
}
