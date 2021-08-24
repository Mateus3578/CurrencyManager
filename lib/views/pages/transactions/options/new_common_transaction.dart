import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/models/DAO/account_DAO.dart';
import 'package:currency_manager/models/DAO/transaction_DAO.dart';
import 'package:currency_manager/models/account_model.dart';
import 'package:currency_manager/models/transaction_model.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/dialogs/exit_confirmation_dialog.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_account_widget.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_date_widget.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_description_widget.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_title_widget.dart';
import 'package:currency_manager/views/pages/transactions/options/widgets/select_value_widget.dart';

class NewCommonTransaction extends StatefulWidget {
  //Tipos de transação suportados.
  static final int revenueType = 1;
  static final int expenseType = 2;

  /// Provider do tema, para acesso as cores
  final ThemeProvider theme;

  /// Provider do saldo, para salvar e notificar as alterações
  final MoneyProvider money;

  /// Tipo de operação. Usar os atributos estáticos da classe ou passar 1 para receita e 2 para despesa.
  final int type;

  /// Opcional: Model para preencher os campos com os dados.
  /// Útil para editar uma transação já criada.
  final TransactionModel? transactionAutoFill;

  NewCommonTransaction({
    required this.theme,
    required this.money,
    required this.type,
    this.transactionAutoFill,
  });

  @override
  _NewCommonTransactionState createState() => _NewCommonTransactionState();
}

class _NewCommonTransactionState extends State<NewCommonTransaction> {
  // Controllers/campos do formulário
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _moreDescController = TextEditingController();

  DateTime _date = DateTime.now();
  bool _isRepeatable = false;
  bool _isFixed = false;
  late AccountModel _account;

  // Espera enquanto está escrevendo os dados
  AccountDAO accountDAO = AccountDAO();
  bool _isAutoFilling = false;

  // Funcões-callback dos widgets que compoem a tela.
  void _setDate(DateTime pickedDate) {
    setState(() => _date = pickedDate);
  }

  void _setAccount(AccountModel pickedAccount) {
    setState(() => _account = pickedAccount);
  }

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

  // Configurando o preenchimento com o model, se tiver
  void autoFill() async {
    setState(() {
      _isAutoFilling = true;
    });

    AccountModel account;
    account = await accountDAO.getAccountById(
      widget.transactionAutoFill!.accountId,
    );

    setState(() {
      //TODO: bug na formatação do valor ao recuperar de uma existente
      _valueController.text = widget.transactionAutoFill!.value.toString();
      _descriptionController.text =
          widget.transactionAutoFill!.description.toString();
      _moreDescController.text =
          widget.transactionAutoFill!.moreDesc.toString();
      _date = DateTime.parse(widget.transactionAutoFill!.date);
      _isRepeatable = widget.transactionAutoFill!.isRepeatable;
      _isFixed = widget.transactionAutoFill!.isFixed;
      //TODO: Bug ao definir a conta recuperada. Problema encontrado.
      //O widget de contas define como carteira ao dar fetchData
      _account = account;
    });

    setState(() {
      _isAutoFilling = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.transactionAutoFill != null) {
      autoFill();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Cor dos ícones. Verde para receita e vermelho para despesa.
    final Color mainColor = widget.type == 1 ? Colors.green : Colors.red;
    return WillPopScope(
      // Dialog confirmando se quer descartar a criação
      onWillPop: () => getExitConfirmationDialog(context),
      // Deixa clicar fora dos campos para tirar o foco da caixa de texto.
      child: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            brightness:
                widget.theme.isDarkMode ? Brightness.dark : Brightness.light,
            toolbarHeight: 0,
            backgroundColor: widget.theme.backgroundColor,
            shadowColor: widget.theme.backgroundColor,
            foregroundColor: widget.theme.backgroundColor,
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Título
                  SelectTitleWidget(title: "Nova Receita"),
                  // Dados. Se estiver escrevendo, espera
                  _isAutoFilling
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: widget.theme.primaryColor,
                            ),
                          ),
                        )
                      : Container(
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
                              SelectDateWidget(
                                initialDate: _date,
                                setDate: _setDate,
                                mainColor: mainColor,
                              ),
                              Divider(color: widget.theme.textColor),
                              SelectAccountWidget(
                                setAccount: _setAccount,
                                moneyProvider: widget.money,
                              ),
                              Divider(color: widget.theme.textColor),
                              // Observações
                              SelectDescWidget(
                                controller: _moreDescController,
                                title: "Observações",
                                validate: false,
                              ),
                              Divider(color: widget.theme.textColor),
                              // Outros
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      SelectTitleWidget(title: "Repetir"),
                                      Switch(
                                        value: _isRepeatable,
                                        onChanged: (value) {
                                          setState(() {
                                            _isRepeatable = value;
                                          });
                                        },
                                        activeTrackColor: mainColor,
                                        activeColor: mainColor,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SelectTitleWidget(title: "Receita Fixa"),
                                      Switch(
                                        value: _isFixed,
                                        onChanged: (value) {
                                          setState(() {
                                            _isFixed = value;
                                          });
                                        },
                                        activeTrackColor: mainColor,
                                        activeColor: mainColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(color: widget.theme.textColor),
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
                                value: value,
                                date: DateFormat("yyyy-MM-dd").format(_date),
                                accountId: _account.idAccount,
                                moreDesc: _moreDescController.text,
                                isFixed: _isFixed,
                                isRepeatable: _isRepeatable,
                              );

                              if (widget.transactionAutoFill == null) {
                                // Salvando a transação no banco de dados
                                await transactionDAO
                                    .insertTransaction(transaction.toMap());

                                // Salvando novo saldo na conta
                                if (widget.type == 1) {
                                  await accountDAO.updateBalanceById(
                                      (_account.balance! + value!),
                                      _account.idAccount);
                                } else if (widget.type == 2) {
                                  await accountDAO.updateBalanceById(
                                      (_account.balance! - value!),
                                      _account.idAccount);
                                }
                              } else {
                                // Salvando a edição
                                await transactionDAO.updateTransactionById(
                                  transaction.toMap(),
                                  widget.transactionAutoFill!.idTransaction,
                                );

                                // Alterando o saldo da conta
                                if (widget.type == 1) {
                                  await accountDAO.updateBalanceById(
                                    (_account.balance! +
                                        value! -
                                        (widget.transactionAutoFill!.value! *
                                            1)),
                                    _account.idAccount,
                                  );
                                } else if (widget.type == 2) {
                                  await accountDAO.updateBalanceById(
                                    (_account.balance! +
                                        (value! * -1) -
                                        (widget.transactionAutoFill!.value! *
                                            1)),
                                    _account.idAccount,
                                  );
                                }
                              }

                              // Reseta os dados de receita/despesa/saldo
                              await widget.money.fetchData();

                              // Fim :)
                              Navigator.of(context).pop(true);
                            }
                          },
                          backgroundColor: mainColor,
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
