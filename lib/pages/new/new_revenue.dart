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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  children: [
                    Row(children: [Text("Valor")]),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "R\$00,00",
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
                          Text(
                            "Hoje",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Ontem",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
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
    );
  }
}
