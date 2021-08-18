import 'package:flutter/material.dart';
import 'package:tc/models/DAO/account_DAO.dart';
import 'package:tc/models/account_model.dart';
import 'package:tc/views/pages/transactions/options/widgets/dialogs/new_account_dialog.dart';

class SelectAccountWidget extends StatefulWidget {
  final Function(AccountModel accountModel) setAccount;
  const SelectAccountWidget(this.setAccount);

  @override
  _SelectAccountWidgetState createState() => _SelectAccountWidgetState();
}

class _SelectAccountWidgetState extends State<SelectAccountWidget> {
  List<AccountModel> _accounts = [];
  List<String> _accountsNames = ["Carteira"];
  // TODO: Salvar a última usada e usar aqui
  String _selectedAccount = "Carteira";
  bool loadingData = true;

  @override
  void initState() {
    super.initState();
    fetchingAccounts();
  }

  /// Busca as contas salvas
  Future<void> fetchingAccounts() async {
    setState(() {
      loadingData = true;
      _accountsNames = [];
    });

    AccountDAO accountDAO = AccountDAO();
    List<AccountModel> data = await accountDAO.getAllAccounts();
    if (data.isNotEmpty) {
      _accounts = data;
      for (int i = 0; i < _accounts.length; i++) {
        _accountsNames.add(_accounts[i].name);
      }
    }
    _accountsNames.add("Criar nova conta");

    setState(() {
      loadingData = false;
      widget.setAccount(matchName(_selectedAccount));
    });
  }

  /// Busca na lista a primeira com o nome escolhido.
  ///
  /// Caso aconteça algo errado, retorna a carteira.
  AccountModel matchName(String name) => _accounts.firstWhere(
        (account) => account.name == name,
        orElse: () =>
            _accounts.firstWhere((account) => account.name == "Carteira"),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text("Conta")]),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedAccount,
            underline: Container(),
            // não constroi enquanto não tiver dados
            items: loadingData
                ? []
                : _accountsNames.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          // TODO: trocar para ícone da conta
                          value == "Selecionar"
                              ? Container()
                              : Icon(Icons.wallet_giftcard),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: value == "Criar nova conta"
                                ? GestureDetector(
                                    onTap: () async {
                                      await getNewAccountDialog(
                                        context,
                                        //TODO: Dar um jeito de resetar a lista
                                        fetchingAccounts,
                                      );
                                    },
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                : Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedAccount = value!;
                widget.setAccount(matchName(_selectedAccount));
              });
            },
          ),
        ),
      ],
    );
  }
}
