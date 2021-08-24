import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/models/DAO/user_DAO.dart';

Future<void> changeNameDialog(BuildContext context, ThemeProvider theme) {
  UserDAO userDAO = UserDAO();
  TextEditingController _controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.backgroundColor,
      title: Text(
        "Digite o novo nome",
        textAlign: TextAlign.center,
        style: TextStyle(color: theme.textColor),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        maxLength: 16,
        style: TextStyle(fontSize: 25, color: theme.textColor),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme.textColor,
              width: 1,
            ),
          ),
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
                onPressed: () {
                  userDAO.updateUserPrefs(
                    UserModelForDb.name,
                    _controller.text,
                  );
                  theme.setUsername(_controller.text);
                  Navigator.of(context).pop(false);
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
