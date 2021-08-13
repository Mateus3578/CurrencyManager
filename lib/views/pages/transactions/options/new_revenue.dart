import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/transaction_DAO.dart';
import 'package:tc/models/transaction_model.dart';
import 'package:tc/views/pages/transactions/options/widgets/exit_confirmation_dialog.dart';
import 'package:tc/views/pages/transactions/options/widgets/new_transaction_description.dart';
import 'package:tc/views/pages/transactions/options/widgets/new_transaction_title.dart';
import 'package:tc/views/pages/transactions/options/widgets/new_transaction_value.dart';

class NewRevenue extends StatefulWidget {
  final ThemeProvider theme;
  NewRevenue(this.theme);

  @override
  _NewRevenueState createState() => _NewRevenueState();
}

class _NewRevenueState extends State<NewRevenue> {
  TransactionDAO transactionDAO = TransactionDAO();
  TransactionModel transaction = TransactionModel();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers do formulário
  TextEditingController _valueController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _moreDescController = TextEditingController();
  DateTime _date = DateTime.now();
  bool _isRepeatable = false;
  bool _isFixed = false;

  _onSaved() async {
    // Reformatando o valor
    // TODO: Fazer algo melhor aqui
    String value = _valueController.text;
    value = value.replaceAll("R\$", "");
    value = value.replaceAll(" ", "");
    value = value.replaceFirst(",", "x", value.length - 3);
    value = value.replaceAll(".", "");
    value = value.replaceAll("x", ".");

    // Montando o mapa
    transaction.type = 1;
    transaction.description = _descriptionController.text;
    // TODO: Arrumar isso assim que arrumar as contas
    transaction.accountId = 1; // !!!
    transaction.value = double.tryParse(value);
    transaction.date = DateFormat("yyyy-MM-dd").format(_date);
    transaction.moreDesc = _moreDescController.text;

    // Salvando no banco de dados
    await transactionDAO.insertTransaction(transaction.toMap());
  }

  /// Abre um pop-up para escolher uma data
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
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
          body: Container(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    // Título
                    NewTransactionTitle(title: "Nova Receita"),
                    // Dados
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          // Valor
                          Row(children: [Text("Valor")]),
                          NewTransactionValue(
                            controller: _valueController,
                          ),
                          Divider(color: widget.theme.textColor),
                          // Descrição
                          Row(children: [Text("Descrição")]),
                          NewTransactionDescription(
                            controller: _descriptionController,
                          ),
                          Divider(color: widget.theme.textColor),
                          Row(children: [Text("Data")]),
                          newTransactionDate(context),
                          Divider(color: widget.theme.textColor),
                          Row(children: [Text("Conta")]),
                          //! Falta as contas
                          //TODO: Buscar as contas do DB
                          //* Sempre abrir na última usada
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Selecionar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.white),
                          Row(
                            children: [Text("Observações")],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              controller: _moreDescController,
                            ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _onSaved();
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
                              child: Text("Confirmar"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding newTransactionDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dia atual
          GestureDetector(
            onTap: () {
              setState(() {
                _date = DateTime.now();
              });
            },
            child: Container(
              decoration: _date.isSameDate(DateTime.now())
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                    )
                  : BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  "Hoje",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          // Dia atual -1
          GestureDetector(
            onTap: () {
              setState(() {
                _date = DateTime.now().subtract(Duration(days: 1));
              });
            },
            child: Container(
              decoration:
                  _date.isSameDate(DateTime.now().subtract(Duration(days: 1)))
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.green,
                            width: 4,
                          ),
                        )
                      : BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  "Ontem",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          // Escolher
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              decoration: !_date.isSameDate(DateTime.now()) &&
                      !_date.isSameDate(
                          DateTime.now().subtract(Duration(days: 1)))
                  ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                    )
                  : BoxDecoration(),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  _date.isSameDate(DateTime.now()) ||
                          _date.isSameDate(
                              DateTime.now().subtract(Duration(days: 1)))
                      ? "Selecionar"
                      : "${DateFormat("dd/MM/yyyy").format(_date)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Compara se duas datas são idênticas.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
