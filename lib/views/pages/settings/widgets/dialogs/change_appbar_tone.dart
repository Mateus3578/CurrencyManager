import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/user_DAO.dart';

Future<void> changeAppbarToneDialog(BuildContext context, ThemeProvider theme) {
  UserDAO userDAO = UserDAO();
  bool tempMode = theme.isDarkMode;
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: theme.backgroundColor,
            title: Text(
              "Altere entre branco e preto",
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.textColor),
            ),
            content: SingleChildScrollView(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Branco"),
                    Switch(
                      value: tempMode,
                      onChanged: (value) {
                        setState(() {
                          tempMode = value;
                          theme.setThemeMode(tempMode);
                        });
                      },
                      activeTrackColor: theme.primaryColor,
                      activeColor: theme.primaryColor,
                    ),
                    Text("Preto"),
                  ],
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
                          UserModelForDb.isDarkMode,
                          tempMode ? "1" : "0",
                        );

                        theme.setThemeMode(tempMode);

                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
