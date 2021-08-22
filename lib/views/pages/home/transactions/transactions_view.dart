import 'package:flutter/material.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/custom/dialogs/delete_dialog.dart';
import 'package:tc/views/pages/home/transactions/transaction_list_tile.dart';
import 'package:tc/views/pages/home/transactions/transaction_view_appbar.dart';
import 'package:tc/views/pages/transactions/options/new_common_transaction.dart';

class TransactionsView extends StatefulWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  TransactionsView({required this.theme, required this.money});

  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  TransactionDAO transactionDAO = TransactionDAO();
  AccountDAO accountDAO = AccountDAO();
  List<TransactionModel> transactions = [];
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  /// Busca os dados e coloca na lista
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<TransactionModel> data = await transactionDAO.getAllTransactions();
    setState(() {
      transactions = data;
    });

    Future.delayed(
      Duration(milliseconds: 250),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        TransactionViewAppbar(
          textColor: widget.theme.textColor,
          transactionsCount: "${transactions.length}",
          monthBalance: _getBalance(transactions),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.27, 0, 0),
          child: !isLoading
              ? RefreshIndicator(
                  onRefresh: fetchData,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification:
                        (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return false;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.12),
                      controller: _scrollController,
                      itemCount: transactions.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            TransactionListTile(
                              type: transactions[index].type,
                              description: transactions[index].description,
                              value: transactions[index].value ?? 0,
                              theme: widget.theme,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewCommonTransaction(
                                      theme: widget.theme,
                                      money: widget.money,
                                      type: transactions[index].type,
                                      transactionAutoFill: transactions[index],
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () async {
                                await getDeleteDialog(
                                  context,
                                  "Você realmente deseja apagar essa transação?",
                                  () async {
                                    AccountModel account =
                                        await accountDAO.getAccountById(
                                      transactions[index].accountId,
                                    );

                                    double newBalance = 0;
                                    if (transactions[index].type == 1) {
                                      newBalance = account.balance! -
                                          (transactions[index].value!);
                                    } else if (transactions[index].type == 2) {
                                      newBalance = account.balance! +
                                          (transactions[index].value!);
                                    }

                                    await accountDAO.updateBalanceById(
                                      newBalance,
                                      transactions[index].accountId,
                                    );

                                    await transactionDAO.deleteTransactionById(
                                      transactions[index].idTransaction,
                                    );
                                    await widget.money.fetchData();
                                    await fetchData();
                                  },
                                );
                              },
                            ),
                            Divider(
                                color: widget.theme.textColor.withAlpha(50)),
                          ],
                        );
                      },
                    ),
                  ),
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: widget.theme.primaryColor,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
