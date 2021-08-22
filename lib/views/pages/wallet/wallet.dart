import 'package:flutter/material.dart';
import 'package:tc/controllers/money_provider.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/custom/dialogs/delete_dialog.dart';
import 'package:tc/views/pages/transactions/options/widgets/dialogs/new_account_dialog.dart';
import 'package:tc/views/pages/wallet/widgets/wallet_appbar.dart';
import 'package:tc/views/pages/wallet/widgets/wallet_list_tile.dart';

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
  final ScrollController _scrollController = ScrollController();

  /// Busca os dados e coloca na lista
  Future<void> fetchData() async {
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
      children: <Widget>[
        WalletAppbar(
          theme: widget.theme,
          monthBalance: _getBalance(transactions),
          moneyProvider: widget.money,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, height * 0.27, 0, 0),
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
                              account: accounts[index],
                              theme: widget.theme,
                              onTap: () async {
                                // TODO: Carregar dados da conta
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
