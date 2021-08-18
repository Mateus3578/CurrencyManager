import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/pages/transactions/options/widgets/dialogs/exit_confirmation_dialog.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_account_widget.dart';
import 'package:tc/views/pages/transactions/save_data.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_date_widget.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_description_widget.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_title_widget.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_value_widget.dart';

class NewRevenue extends StatefulWidget {
  final ThemeProvider theme;
  final int type = 1;
  NewRevenue(this.theme);

  @override
  _NewRevenueState createState() => _NewRevenueState();
}

class _NewRevenueState extends State<NewRevenue> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers do formulário
  TextEditingController _valueController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _moreDescController = TextEditingController();

  DateTime _date = DateTime.now();
  bool _isRepeatable = false;
  bool _isFixed = false;
  late AccountModel _account;

  // Funcões callback
  void setDate(DateTime pickedDate) {
    setState(() => _date = pickedDate);
  }

  void setAccount(AccountModel pickedAccount) {
    setState(() => _account = pickedAccount);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => getExitConfirmationDialog(context),
      child: Listener(
        // Deixa clicar fora dos campos para tirar o foco da caixa de texto.
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  // Título
                  NewTitle(title: "Nova Receita"),
                  // Dados
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        // Valor
                        SelectValueWidget(
                          controller: _valueController,
                          title: "Valor",
                        ),
                        Divider(color: widget.theme.textColor),
                        // Descrição
                        SelectDescWidget(
                          controller: _descriptionController,
                          title: "Descrição",
                        ),
                        Divider(color: widget.theme.textColor),
                        // Data
                        SelectDateWidget(setDate),
                        Divider(color: widget.theme.textColor),
                        SelectAccountWidget(setAccount),
                        Divider(color: Colors.white),
                        // Observações
                        SelectDescWidget(
                          controller: _moreDescController,
                          title: "Observações",
                          validate: false,
                        ),
                        Divider(color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Repetir",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Switch(
                                        value: _isRepeatable,
                                        onChanged: (value) {
                                          setState(() {
                                            _isRepeatable = value;
                                          });
                                        },
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Receita Fixa",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Switch(
                                        value: _isFixed,
                                        onChanged: (value) {
                                          setState(() {
                                            _isFixed = value;
                                          });
                                        },
                                        activeTrackColor: Colors.green,
                                        activeColor: Colors.green,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white),
                      ],
                    ),
                  ),
                  // Confirmação
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        FloatingActionButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                _account.idAccount != null) {
                              TransactionDAO transactionDAO = TransactionDAO();
                              AccountDAO accountDAO = AccountDAO();

                              double? value = double.tryParse(
                                formatValue(_valueController.text),
                              );

                              // Montando o objeto/mapa da transação
                              TransactionModel transaction = TransactionModel(
                                type: widget.type,
                                description: _descriptionController.text,
                                value: double.tryParse(
                                  formatValue(_valueController.text),
                                ),
                                date: DateFormat("yyyy-MM-dd").format(_date),
                                accountId: _account.idAccount,
                                moreDesc: _moreDescController.text,
                              );
                              // Salvando no banco de dados
                              await transactionDAO
                                  .insertTransaction(transaction.toMap());
                              await accountDAO.updateBalanceById(
                                  // Diminui se for despesa, soma se for receita
                                  widget.type == 2
                                      ? (_account.balance! + (value! * -1))
                                      : (_account.balance! + value!),
                                  _account.idAccount);

                              Navigator.of(context).pop(true);
                            }
                          },
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Salvar"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
