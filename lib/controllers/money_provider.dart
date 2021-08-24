import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_manager/models/DAO/account_DAO.dart';
import 'package:currency_manager/models/DAO/transaction_DAO.dart';
import 'package:currency_manager/models/account_model.dart';
import 'package:currency_manager/models/transaction_model.dart';

class MoneyProvider extends ChangeNotifier {
  double _currentBalance = 0;
  double _currentRevenueBalance = 0;
  double _currentExpenseBalance = 0;

  get balance => _currentBalance;
  get revenues => _currentRevenueBalance;
  get expenses => _currentExpenseBalance;

  /// Busca os dados no db.
  fetchData() async {
    AccountDAO accountDAO = AccountDAO();
    TransactionDAO transactionDAO = TransactionDAO();

    double tempBalance = 0;
    double tempRevenues = 0;
    double tempExpenses = 0;

    List<AccountModel> dataAccount = await accountDAO.getAllAccounts();
    if (dataAccount.isNotEmpty) {
      for (int i = 0; i < dataAccount.length; i++) {
        tempBalance += dataAccount[i].balance!;
      }
    }

    String firstDate = DateFormat("yyyy-MM").format(DateTime.now()) + "-01";
    String lastDate = DateFormat("yyyy-MM").format(DateTime.now()) + "-31";

    List<TransactionModel> dataTransaction =
        await transactionDAO.getTransactionsByPeriod(
      firstDate,
      lastDate,
    );
    if (dataTransaction.isNotEmpty) {
      for (int i = 0; i < dataTransaction.length; i++) {
        if (dataTransaction[i].type == 1) {
          tempRevenues += dataTransaction[i].value!;
        } else if (dataTransaction[i].type == 2) {
          tempExpenses += dataTransaction[i].value!;
        }
      }
    }

    setBalance(tempBalance);
    setRevenues(tempRevenues);
    setExpenses(tempExpenses);
  }

  setBalance(double value) {
    _currentBalance = value;
    notifyListeners();
  }

  setRevenues(double value) {
    _currentRevenueBalance = value;
    notifyListeners();
  }

  setExpenses(double value) {
    _currentExpenseBalance = value;
    notifyListeners();
  }
}
