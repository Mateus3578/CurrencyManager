import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/settings/widgets/choose_theme.dart';
import 'package:tc/views/pages/settings/widgets/custom_theme_setting.dart';
import 'package:tc/views/pages/settings/widgets/dialogs/change_name_dialog.dart';

class Settings extends StatelessWidget {
  final ThemeProvider theme;
  Settings(this.theme);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, size.height * 0.020),
              child: Text(
                "Configurações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.textColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        tileButton(
          size,
          "Mudar nome de usuário",
          () => changeNameDialog(context, theme),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        tileButton(
          size,
          "Escolher tema pré-definido",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChooseTheme(theme),
              ),
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        tileButton(
          size,
          "Customizar tema",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomThemeSetting(theme),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget tileButton(Size size, String text, onTap) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        alignment: Alignment.centerRight,
        width: size.width,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme.primaryColor,
            width: 2,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
