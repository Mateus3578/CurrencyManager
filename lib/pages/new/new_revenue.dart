import 'package:flutter/material.dart';

class NewRevenue extends StatefulWidget {
  final MaterialColor color;
  const NewRevenue({Key? key, required this.color}) : super(key: key);

  @override
  _NewRevenueState createState() => _NewRevenueState();
}

class _NewRevenueState extends State<NewRevenue> {
  bool _isFixed = false;
  bool _isRepeatable = false;
  String _date = "";

  // Pop-up com confirmação para cancelar a criação da transação
  // O ´´?? false´´ lá no final é para permitir voltar apertando fora do pop-up sem explodir tudo
  Future<bool> _onExit() async {
    return (await showDialog(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onExit,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Column(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Nova Receita",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
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
                      Row(children: [Text("Valor")]),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              "R\$50,00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Row(children: [Text("Descrição")]),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              "Compra",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Row(children: [Text("Data")]),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _date = "hoje";
                                });
                              },
                              child: Container(
                                decoration: _date == "hoje"
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _date = "ontem";
                                });
                              },
                              child: Container(
                                decoration: _date == "ontem"
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _date = "choose";
                                });
                              },
                              child: Container(
                                decoration: _date == "choose"
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        border: Border.all(
                                          color: widget.color,
                                          width: 4,
                                        ),
                                      )
                                    : BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    "Selecionar",
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
          ],
        ),
      ),
    );
  }
}
