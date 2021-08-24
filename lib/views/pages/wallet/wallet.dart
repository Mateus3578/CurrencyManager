import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_manager/controllers/constants.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/models/DAO/account_DAO.dart';
import 'package:currency_manager/models/DAO/transaction_DAO.dart';
import 'package:currency_manager/models/account_model.dart';
import 'package:currency_manager/models/transaction_model.dart';
import 'package:currency_manager/views/custom/dialogs/delete_dialog.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/dialogs/new_account_dialog.dart';
import 'package:currency_manager/views/pages/wallet/widgets/wallet_appbar.dart';
import 'package:currency_manager/views/pages/wallet/widgets/wallet_list_tile.dart';

class Wallet extends StatefulWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  Wallet({required this.theme, required this.money});

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final ScrollController _scrollController = ScrollController();

  AccountDAO accountDAO = AccountDAO();
  TransactionDAO transactionDAO = TransactionDAO();
  List<AccountModel> accounts = [];
  List<TransactionModel> transactions = [];
  bool isLoading = false;
  DateTime date = DateTime.now();

  /// Busca os dados e coloca na lista
  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<AccountModel> dataAccounts = await accountDAO.getAllAccounts();
    if (dataAccounts.isNotEmpty) {
      accounts = dataAccounts;
    }
    String firstDate = DateFormat("yyyy-MM").format(date) + "-01";
    String lastDate = DateFormat("yyyy-MM").format(date) + "-31";

    List<TransactionModel> data = await transactionDAO.getTransactionsByPeriod(
      firstDate,
      lastDate,
    );

    setState(() {
      transactions = data;
    });

    Future.delayed(Duration(milliseconds: 250), () {
      setState(() {
        isLoading = false;
      });
    });
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

  double _getMonthBalanceOfAccount(List<TransactionModel> list, int? id) {
    double balance = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].accountId == id) {
        if (list[i].type == 1) {
          balance += list[i].value!;
        } else if (list[i].type == 2) {
          balance -= list[i].value!;
        }
      }
    }
    return balance;
  }

  double _getMonthBalance(List<TransactionModel> list) {
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
      children: <Widget>[
        WalletAppbar(
          theme: widget.theme,
          currentMonth: Constants.months[date.month],
          monthBalance: _getMonthBalance(transactions),
          moneyProvider: widget.money,
          onPressedNext: () async {
            setState(() {
              date = DateTime(date.year, date.month + 1, date.day);
            });
            await fetchData();
          },
          onPressedPrevious: () async {
            setState(() {
              date = DateTime(date.year, date.month - 1, date.day);
            });
            await fetchData();
          },
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.2, 0, 0),
          child: accounts.isNotEmpty && !isLoading
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
                      itemCount: accounts.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            WalletListTile(
                              accountName: accounts[index].name,
                              accountBalanceMonth: _getMonthBalanceOfAccount(
                                transactions,
                                accounts[index].idAccount,
                              ),
                              theme: widget.theme,
                              onTap: () async {
                                await getNewAccountDialog(
                                  context: context,
                                  moneyProvider: widget.money,
                                  accountAutoFill: accounts[index],
                                );
                                await fetchData();
                              },
                              onLongPress: () async {
                                // Não pode apaga a carteira porque sim
                                if (accounts[index].idAccount != 1) {
                                  await getDeleteDialog(
                                    context,
                                    "Você realmente deseja apagar essa conta?",
                                    () async {
                                      await accountDAO.deleteAccountById(
                                        accounts[index].idAccount,
                                      );
                                      await widget.money.fetchData();
                                      await fetchData();
                                    },
                                  );
                                }
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
        )
      ],
    );
  }
}
