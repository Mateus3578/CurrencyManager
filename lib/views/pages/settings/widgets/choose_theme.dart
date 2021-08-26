import 'package:flutter/material.dart';
import 'package:currency_manager/controllers/theme_provider.dart';
import 'package:currency_manager/models/DAO/user_DAO.dart';
import 'package:currency_manager/views/custom/prebuilt_themes.dart';
import 'package:currency_manager/models/user_model.dart';
import 'package:currency_manager/views/custom/custom_animated_bounce.dart';
import 'package:currency_manager/views/custom/navbar_custom_painter.dart';

class ChooseTheme extends StatelessWidget {
  final ThemeProvider theme;
  ChooseTheme(this.theme);

  //Lista de temas, na ordem de exibição
  final List<PreBuiltThemeModel> themes = [
    PrebuiltThemes.defaultTheme,
    PrebuiltThemes.defaultThemeReverse,
    PrebuiltThemes.magicGrey,
    PrebuiltThemes.magicGreyReverse,
    PrebuiltThemes.materialBlue,
    PrebuiltThemes.materialBlueReverse,
    PrebuiltThemes.purple,
    PrebuiltThemes.purpleReverse,
    PrebuiltThemes.lilac,
    PrebuiltThemes.lilacReverse,
    PrebuiltThemes.pastelPink,
    PrebuiltThemes.pastelPinkReverse,
    PrebuiltThemes.blackWhite,
    PrebuiltThemes.blackWhiteReverse,
    PrebuiltThemes.islandGreen,
    PrebuiltThemes.islandGreenReverse,
    PrebuiltThemes.tomato,
    PrebuiltThemes.tomatoReverse,
    PrebuiltThemes.bank,
    PrebuiltThemes.bankAlter,
  ];

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        brightness: theme.isDarkMode ? Brightness.dark : Brightness.light,
        toolbarHeight: 0,
        backgroundColor: theme.backgroundColor,
        shadowColor: theme.backgroundColor,
        foregroundColor: theme.backgroundColor,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Escolha um tema",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          CustomAnimatedBounce(
            child: Icon(
              Icons.expand_more,
              color: theme.textColor,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: _size.height * 0.7,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.primaryColor,
                  width: 5,
                ),
              ),
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(0, 0, 0, _size.height * 0.12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: themes.length,
                itemBuilder: (context, index) {
                  return exampleTheme(themes[index], _size);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomMenuMimic(context),
    );
  }

  _onSave(UserModel user) async {
    UserDAO userDAO = UserDAO();
    await userDAO.updateTheme(user.toMap());

    theme.setPrimaryColor(Color(int.parse(user.primaryColor)));
    theme.setAlterColor(Color(int.parse(user.alterColor)));
    theme.setBackgroundColor(Color(int.parse(user.backgroundColor)));
    theme.setTextColor(Color(int.parse(user.textColor)));
    theme.setIconColor(Color(int.parse(user.iconColor)));
    theme.setThemeMode(user.isDarkMode);
  }

  Widget exampleTheme(PreBuiltThemeModel prebuiltTheme, Size size) {
    return GestureDetector(
      onTap: () {
        UserModel user = UserModel(
          name: theme.username,
          backgroundColor: "${prebuiltTheme.background.value}",
          primaryColor: "${prebuiltTheme.primary.value}",
          alterColor: "${prebuiltTheme.alter.value}",
          iconColor: "${prebuiltTheme.icon.value}",
          textColor: "${prebuiltTheme.text.value}",
          isDarkMode: prebuiltTheme.isDarkMode,
        );
        _onSave(user);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: prebuiltTheme.background,
                border: Border.all(
                  color: prebuiltTheme.primary,
                  width: 3,
                ),
              ),
              height: 50,
              width: size.width,
              child: Center(
                child: Text(
                  "TEXTO",
                  style: TextStyle(color: prebuiltTheme.text),
                ),
              ),
            ),
            Container(
              height: 50,
              color: prebuiltTheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: prebuiltTheme.alter,
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: prebuiltTheme.icon,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "TEXTO",
                      style: TextStyle(color: prebuiltTheme.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomMenuMimic(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: NavbarCustomPainter(theme.primaryColor),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              elevation: 0,
              disabledElevation: 0,
              backgroundColor: theme.alterColor,
              onPressed: () => Navigator.pop(context),
              child: Icon(
                Icons.home,
                color: theme.iconColor,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
