import 'package:flutter/material.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_description_widget.dart';
import 'package:tc/views/pages/transactions/options/widgets/select_value_widget.dart';
import 'package:tc/views/pages/transactions/save_data.dart';

/// Pop-up da criação de nova conta.
Future<void> getNewAccountDialog(
    BuildContext context, Function refetchData) async {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AccountDAO _accountDAO = AccountDAO();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Nova Conta", textAlign: TextAlign.center),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Valor
              SelectValueWidget(
                controller: _balanceController,
                title: "Saldo inicial",
              ),
              // Descrição
              SelectDescWidget(
                controller: _nameController,
                title: "Nome",
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      AccountModel account = AccountModel(
                        name: _nameController.text,
                        balance: double.tryParse(
                          formatValue(_balanceController.text),
                        ),
                      );
                      await _accountDAO.insertAccount(account.toMap());
                      await refetchData();
                      Navigator.of(context).pop(true);
                    }
                  },
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
          ],
        ),
      ],
    ),
  );
}
