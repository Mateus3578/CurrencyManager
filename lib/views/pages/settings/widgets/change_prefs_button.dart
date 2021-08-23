import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/user_DAO.dart';
import 'package:tc/views/pages/settings/widgets/dialogs/change_appbar_tone.dart';
import 'package:tc/views/pages/settings/widgets/dialogs/change_color_dialog.dart';

class ChangePrefsButton extends StatefulWidget {
  /// Texto do botão
  final String text;

  /// Nome da pref. a ser alterada.
  ///
  /// Usar a classe [`UserModelForDb`]
  final String prefId;
  final ThemeProvider theme;

  /// Widget com um botão que abre um dialog para mudar um item do tema
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
          widget.prefId == UserModelForDb.isDarkMode
              ? changeAppbarToneDialog(context, widget.theme)
              : changeColorDialog(context, widget.theme, widget.prefId);
        },
      ),
    );
  }
}
