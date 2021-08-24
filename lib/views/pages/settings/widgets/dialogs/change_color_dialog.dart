import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/models/DAO/user_DAO.dart';

//TODO: Impedir/remediar o usuário que colocar a cor do texto e fundo iguais

Future<void> changeColorDialog(
  BuildContext context,
  ThemeProvider theme,
  String prefId,
) {
  UserDAO userDAO = UserDAO();
  Color _pickerColor = Color(0xFFFF0000);
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: theme.backgroundColor,
      title: Text(
        "Escolha uma cor",
        textAlign: TextAlign.center,
        style: TextStyle(color: theme.textColor),
      ),
      content: SingleChildScrollView(
        //TODO: RUIM, mudar colorPicker
        child: CircleColorPicker(
          controller: CircleColorPickerController(),
          textStyle: TextStyle(color: theme.textColor),
          onChanged: (color) {
            _pickerColor = color;
          },
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
                    prefId,
                    _pickerColor.value.toString(),
                  );

                  // Uma pena, switch case não funciona nesse caso,
                  // então aprecie esse raro if-else chain

                  // Main Color
                  if (prefId == UserModelForDb.primaryColor)
                    theme.setPrimaryColor(_pickerColor);
                  // Alter Color
                  else if (prefId == UserModelForDb.alterColor)
                    theme.setAlterColor(_pickerColor);
                  // Background Color
                  else if (prefId == UserModelForDb.backgroundColor)
                    theme.setBackgroundColor(_pickerColor);
                  // Text Color
                  else if (prefId == UserModelForDb.textColor)
                    theme.setTextColor(_pickerColor);
                  // Icon Color
                  else if (prefId == UserModelForDb.iconColor)
                    theme.setIconColor(_pickerColor);

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
