import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:tc/classes/app_database.dart';
import 'package:tc/models/transaction.dart';

class NewRevenue extends StatefulWidget {
  final MaterialColor color;
  const NewRevenue({Key? key, required this.color}) : super(key: key);

  @override
  _NewRevenueState createState() => _NewRevenueState();
}

class _NewRevenueState extends State<NewRevenue> {
  Transaction transaction = Transaction();
  AppDatabase db = AppDatabase.instance;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController moreDescController = TextEditingController();

  bool _isFixed = false;
  bool _isRepeatable = false;
  DateTime _date = DateTime.now();

  /// Pop-up com confirmação para cancelar a criação da transação.
  Future<bool> _onExit() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmação", textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 2),
                child: Text(
                  "Deseja descartar as alterações?",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: TextButton(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: TextButton(
                  child: Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  /// Abre um pop-up para escolher uma data
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  _onSaved() async {
    // Reformatando o valor
    // TODO: Fazer algo melhor aqui
    String value = valueController.text;
    value = value.replaceAll("R\$", "");
    value = value.replaceAll(" ", "");
    value = value.replaceFirst(",", "x", value.length - 3);
    value = value.replaceAll(".", "");
    value = value.replaceAll("x", ".");

    // Montando o mapa
    transaction.type = 1;
    transaction.description = descriptionController.text;
    transaction.accountId = 1; // !!! //TODO: Arrumar isso
    transaction.value = double.tryParse(value);
    transaction.date = DateFormat("yyyy-MM-dd").format(_date);
    transaction.moreDesc = moreDescController.text;

    // Salvando no banco de dados
    await db.insert(TransactionForDb.tableName, transaction.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onExit,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  // Título
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nova Receita",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dados
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        // Valor
                        Row(children: [Text("Valor")]),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            //TODO: Formatar apenas para mostrar
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                locale: "pt-br",
                                decimalDigits: 2,
                                symbol: "R\$",
                              ),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "R\$0,00",
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            controller: valueController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Insira um valor";
                              }
                            },
                          ),
                        ),
                        Divider(color: Colors.white),
                        // Descrição
                        Row(children: [Text("Descrição")]),
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
                            controller: descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Insira uma descrição";
                              }
                            },
                          ),
                        ),
                        Divider(color: Colors.white),
                        Row(children: [Text("Data")]),
                        Padding(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: widget.color,
                                          border: Border.all(
                                            color: widget.color,
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
                                    _date = DateTime.now()
                                        .subtract(Duration(days: 1));
                                  });
                                },
                                child: Container(
                                  decoration: _date.isSameDate(DateTime.now()
                                          .subtract(Duration(days: 1)))
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: widget.color,
                                          border: Border.all(
                                            color: widget.color,
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
                                  decoration:
                                      !_date.isSameDate(DateTime.now()) &&
                                              !_date.isSameDate(DateTime.now()
                                                  .subtract(Duration(days: 1)))
                                          ? BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              color: widget.color,
                                              border: Border.all(
                                                color: widget.color,
                                                width: 4,
                                              ),
                                            )
                                          : BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Text(
                                      _date.isSameDate(DateTime.now()) ||
                                              _date.isSameDate(DateTime.now()
                                                  .subtract(Duration(days: 1)))
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
                        ),
                        Divider(color: Colors.white),
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
                        Row(children: [Text("Observações")]),
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
                            controller: moreDescController,
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
                                        activeTrackColor: widget.color,
                                        activeColor: widget.color,
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
                                        activeTrackColor: widget.color,
                                        activeColor: widget.color,
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
                            backgroundColor: widget.color,
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
    );
  }
}

/// Compara duas datas.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
