import 'package:flutter/material.dart';
import 'package:tc/classes/app_colors.dart';
import 'package:tc/views/pages/settings/widgets/color_change.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors.instance;
    return Scaffold(
      backgroundColor: appColors.colors["background"],
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            ColorChange(text: "Mudar cor principal", colorID: "main"),
            ColorChange(text: "Mudar cor de fundo", colorID: "background"),
          ],
        ),
      ),
    );
  }
}
