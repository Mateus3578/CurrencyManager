import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:tc/classes/app_colors.dart';
import 'package:tc/classes/restart_widget.dart';

class ColorChange extends StatelessWidget {
  final String text;
  final String colorID;

  ColorChange({Key? key, required this.text, required this.colorID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors.instance;
    return TextButton(
      child: Text(text),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: () {
        Color pickerColor = Color(0xFFFF0000);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Escolha uma cor", textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CircleColorPicker(
                    controller: CircleColorPickerController(),
                    onChanged: (color) {
                      pickerColor = color;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 2),
                    child:
                        Text("Ao clicar em confirmar, o app será reiniciado."),
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
                      onPressed: () {
                        appColors.changeColor(pickerColor, colorID);
                        RestartWidget.restartApp(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
