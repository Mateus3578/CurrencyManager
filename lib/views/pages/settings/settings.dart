import 'package:flutter/material.dart';
import 'package:tc/models/user.dart';
import 'package:tc/views/pages/settings/widgets/color_change.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Column(
          children: [
            SizedBox(height: 200),
            ColorChange(
              text: "Mudar cor principal",
              colorId: UserForDb.mainColor,
            ),
            ColorChange(
              text: "Mudar cor de fundo",
              colorId: UserForDb.backgroundColor,
            ),
          ],
        ),
      ],
    );
  }
}
// TODO: Opção para mudar o nome do usuário