import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/models/DAO/account_DAO.dart';
import 'package:currency_manager/models/account_model.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_description_widget.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_value_widget.dart';

/// Pop-up da criação de nova conta.
Future<void> getNewAccountDialog({
  required BuildContext context,
  required MoneyProvider moneyProvider,

  /// Opcional: Model para preencher os campos com os dados.
  /// Útil para editar uma transação já criada.
  AccountModel? accountAutoFill,
}) async {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AccountDAO _accountDAO = AccountDAO();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _balanceController = TextEditingController();

  /// Formata uma string(valor) para salvar no db.
  String formatValue(String value) {
    // TODO: Fazer algo melhor aqui
    String formattedValue = value;
    formattedValue = formattedValue.replaceAll("R\$", "");
    formattedValue = formattedValue.replaceAll(" ", "");
    formattedValue = formattedValue.replaceAll(",", "x");
    formattedValue = formattedValue.replaceAll(".", "");
    formattedValue = formattedValue.replaceAll("x", ".");
    return formattedValue;
  }

  if (accountAutoFill != null) {
    _nameController.text = accountAutoFill.name;
    //TODO: Bug na formatação do valor recuperado
    _balanceController.text = accountAutoFill.balance.toString();
  }

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
                      if (accountAutoFill == null) {
                        AccountModel account = AccountModel(
                          name: _nameController.text,
                          balance: double.tryParse(
                            formatValue(_balanceController.text),
                          ),
                        );
                        await _accountDAO.insertAccount(account.toMap());
                      } else {
                        await _accountDAO.updateAccountById(
                          _nameController.text,
                          double.tryParse(
                            formatValue(_balanceController.text),
                          ),
                          accountAutoFill.idAccount,
                        );
                      }
                      await moneyProvider.fetchData();
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
