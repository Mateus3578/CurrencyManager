import 'package:flutter/material.dart';

/// Pop-up com confirmação para excluir algo.
Future<bool> getDeleteDialog(
  BuildContext context,
  String text,
  onPressedConfirm,
) async {
  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Confirmação", textAlign: TextAlign.center),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Essa ação não pode ser desfeita.",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
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
                onPressed: () async {
                  await onPressedConfirm();
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ));
}
