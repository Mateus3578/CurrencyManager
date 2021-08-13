import 'package:flutter/material.dart';

/// Pop-up com confirmação para cancelar a criação da transação.
Future<bool> getExitConfirmationDialog(BuildContext context) async {
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
