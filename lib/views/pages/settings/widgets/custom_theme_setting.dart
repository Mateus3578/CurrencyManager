import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/user_DAO.dart';
import 'package:tc/views/pages/settings/widgets/change_prefs_button.dart';

class CustomThemeSetting extends StatelessWidget {
  final ThemeProvider theme;
  CustomThemeSetting(this.theme);

  // TODO: Exemplo do que muda em cada opção

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        brightness: theme.isDarkMode ? Brightness.dark : Brightness.light,
        toolbarHeight: 0,
        backgroundColor: theme.backgroundColor,
        shadowColor: theme.backgroundColor,
        foregroundColor: theme.backgroundColor,
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            left: 0,
            top: MediaQuery.of(context).size.height * 0.07,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20, 0, 0, height * 0.020),
              child: Text(
                "Configurações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.textColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: MediaQuery.of(context).padding.top),
                ChangePrefsButton(
                  text: "Mudar cor principal",
                  prefId: UserModelForDb.primaryColor,
                  theme: theme,
                ),
                ChangePrefsButton(
                  text: "Mudar cor secundária",
                  prefId: UserModelForDb.alterColor,
                  theme: theme,
                ),
                ChangePrefsButton(
                  text: "Mudar cor de fundo",
                  prefId: UserModelForDb.backgroundColor,
                  theme: theme,
                ),
                ChangePrefsButton(
                  text: "Mudar cor do texto",
                  prefId: UserModelForDb.textColor,
                  theme: theme,
                ),
                ChangePrefsButton(
                  text: "Mudar cor dos ícones",
                  prefId: UserModelForDb.iconColor,
                  theme: theme,
                ),
                ChangePrefsButton(
                  text: "Mudar tom da barra de notificações",
                  prefId: UserModelForDb.isDarkMode,
                  theme: theme,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
