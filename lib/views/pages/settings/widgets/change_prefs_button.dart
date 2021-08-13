import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/settings/widgets/dialogs/change_color_dialog.dart';

/// Widget com um botão que muda a cor e reinicia o app
class ChangePrefsButton extends StatefulWidget {
  final String text;
  final String prefId;
  final ThemeProvider theme;

  ChangePrefsButton({
    required this.text,
    required this.prefId,
    required this.theme,
  });

  @override
  _ChangePrefsButtonState createState() => _ChangePrefsButtonState();
}

class _ChangePrefsButtonState extends State<ChangePrefsButton> {
  @override
  Widget build(BuildContext context) {
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
          changeColorDialog(context, widget.theme, widget.prefId);
        },
      ),
    );
  }
}
