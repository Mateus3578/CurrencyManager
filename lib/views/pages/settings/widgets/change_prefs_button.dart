import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:tc/controllers/database_helper.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/user_model.dart';

/// Widget com um botão que muda a cor e reinicia o app
class ChangePrefsButton extends StatefulWidget {
  final String text;
  final String prefId;
  final ThemeProvider theme;

  ChangePrefsButton({
    Key? key,
    required this.text,
    required this.prefId,
    required this.theme,
  }) : super(key: key);

  @override
  _ChangePrefsButtonState createState() => _ChangePrefsButtonState();
}

class _ChangePrefsButtonState extends State<ChangePrefsButton> {
  TextEditingController _controller = TextEditingController();
  Color _pickerColor = Color(0xFFFF0000);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper db = DatabaseHelper.instance;
    return Container(
      child: TextButton(
        child:
            Text(widget.text, style: TextStyle(color: widget.theme.textColor)),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(
                color: widget.theme.primaryColor,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: widget.theme.backgroundColor,
              title: Text(
                widget.prefId == UserModelForDb.name
                    ? "Digite o novo nome"
                    : "Escolha uma cor",
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.theme.textColor),
              ),
              content: widget.prefId == UserModelForDb.name
                  ? TextField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      maxLength: 16,
                      style: TextStyle(
                          fontSize: 25, color: widget.theme.textColor),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: widget.theme.textColor,
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      //TODO: RUIM, mudar colorPicker
                      child: CircleColorPicker(
                        controller: CircleColorPickerController(),
                        textStyle: TextStyle(color: widget.theme.textColor),
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
                          db.updateUserPrefs(
                            widget.prefId,
                            widget.prefId == UserModelForDb.name
                                ? _controller.text
                                : _pickerColor.value.toString(),
                          );
                          // Uma pena, switch case não funciona nesse caso,
                          // então aprecie esse raro if-else chain

                          // Main Color
                          if (widget.prefId == UserModelForDb.primaryColor)
                            widget.theme.setPrimaryColor(_pickerColor);
                          // Alter Color
                          if (widget.prefId == UserModelForDb.alterColor)
                            widget.theme.setAlterColor(_pickerColor);
                          // Background Color
                          else if (widget.prefId ==
                              UserModelForDb.backgroundColor)
                            widget.theme.setBackgroundColor(_pickerColor);
                          // Text Color
                          else if (widget.prefId == UserModelForDb.textColor)
                            widget.theme.setTextColor(_pickerColor);
                          // Icon Color
                          else if (widget.prefId == UserModelForDb.iconColor)
                            widget.theme.setIconColor(_pickerColor);
                          else if (widget.prefId == UserModelForDb.name)
                            widget.theme.setUsername(_controller.text);

                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
