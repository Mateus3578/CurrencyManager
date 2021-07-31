import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/user_model.dart';
import 'package:tc/views/pages/settings/widgets/change_prefs_button.dart';

class Settings extends StatelessWidget {
  final ThemeProvider theme;
  Settings(this.theme);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
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
                text: "Mudar nome",
                prefId: UserModelForDb.name,
                theme: theme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// TODO: Opção para mudar o nome do usuário
// TODO: Temas pré-definidos