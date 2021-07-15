import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:tc/models/transaction.dart';

//TODO: Organizar. Muitas linhas. Separar
//! Parei nas contas

/// Compara duas datas.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

class NewRevenue extends StatefulWidget {
  final MaterialColor color;
  const NewRevenue({Key? key, required this.color}) : super(key: key);

  @override
  _NewRevenueState createState() => _NewRevenueState();
}

class _NewRevenueState extends State<NewRevenue> {
  Transaction transaction = new Transaction();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController valueController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController moreDescController = TextEditingController();

  bool _isFixed = false;
  bool _isRepeatable = false;
  DateTime _date = DateTime.now();

  /// Pop-up com confirmação para cancelar a criação da transação.
  /// O ´´?? false´´ lá no final é para permitir voltar apertando fora do pop-up sem explodir tudo
  Future<bool> _onExit() async {
    return (await showDialog(
          //TODO: MUITO FEIO, EMBELEZAR
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Confirmação",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Deseja descartar as alterações?",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              "Não",
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              "Sim",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  /// Abre um pop-up para escolher uma data
  // TODO: Verificar em portugues. Parece estranho
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
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  // Título
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
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
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        // Valor
                        Row(children: [Text("Valor")]),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                locale: "pt-br",
                                decimalDigits: 2,
                                symbol: "R\$",
                              ),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "R\$0,00",
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            controller: valueController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  num.tryParse(value) == null ||
                                  double.parse(value) < 0) {
                                return "Insira um valor válido";
                              }
                            },
                            onSaved: (value) {
                              if (value != null) {
                                transaction.value = double.tryParse(value);
                              }
                            },
                          ),
                        ),
                        Divider(color: Colors.white),
                        // Descrição
                        Row(children: [Text("Descrição")]),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText:
                                  "Descrição", //TODO: Escolher entre título e hint ou pensar em uma melhor
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
                            onSaved: (value) {
                              if (value != null) {
                                transaction.description = value;
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
                                          : "${_date.day}/${_date.month}/${_date.year}",
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
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "Nada a declarar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(color: Colors.white),
                        Row(children: [Text("Repetição")]),
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
                                        "Repetir?",
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
                                        "Receita Fixa?",
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
                            onPressed: () {},
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
