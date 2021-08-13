import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/DAO/user_DAO.dart';
import 'package:tc/views/custom/prebuilt_themes.dart';
import 'package:tc/models/user_model.dart';
import 'package:tc/views/custom/custom_animated_shake.dart';
import 'package:tc/views/custom/navbar_custom_painter.dart';

class ChooseTheme extends StatelessWidget {
  final ThemeProvider theme;
  ChooseTheme(this.theme);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                height: _size.height * 0.14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Escolha um tema",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "O menu é apenas para visualização",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: _size.height * 0.185,
            child: CustomAnimatedShake(
              child: Icon(
                Icons.expand_more,
                color: theme.textColor,
              ),
            ),
          ),
          Positioned(
            top: _size.height * 0.22,
            height: _size.height * 0.65,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: theme.primaryColor,
                    width: 5,
                  ),
                ),
                child: GridView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, _size.height * 0.12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  children: [
                    //TODO: Buscar as cores/temas de um jeito melhor
                    exampleTheme(
                      Bee.primary,
                      Bee.alter,
                      Bee.background,
                      Bee.text,
                      Bee.icon,
                      _size,
                    ),
                    exampleTheme(
                      HighContrast.primary,
                      HighContrast.alter,
                      HighContrast.background,
                      HighContrast.text,
                      HighContrast.icon,
                      _size,
                    ),
                    exampleTheme(
                      MaterialBlue.primary,
                      MaterialBlue.alter,
                      MaterialBlue.background,
                      MaterialBlue.text,
                      MaterialBlue.icon,
                      _size,
                    ),
                    exampleTheme(
                      PastelPink.primary,
                      PastelPink.alter,
                      PastelPink.background,
                      PastelPink.text,
                      PastelPink.icon,
                      _size,
                    ),
                    exampleTheme(
                      RedBrown.primary,
                      RedBrown.alter,
                      RedBrown.background,
                      RedBrown.text,
                      RedBrown.icon,
                      _size,
                    ),
                    exampleTheme(
                      Marley.primary,
                      Marley.alter,
                      Marley.background,
                      Marley.text,
                      Marley.icon,
                      _size,
                    )
                  ],
                ),
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
  }

  Widget exampleTheme(
    Color primary,
    Color alter,
    Color background,
    Color text,
    Color icon,
    Size size,
  ) {
    return GestureDetector(
      onTap: () {
        UserModel user = UserModel(
          name: theme.username,
          backgroundColor: "${background.value}",
          primaryColor: "${primary.value}",
          alterColor: "${alter.value}",
          iconColor: "${icon.value}",
          textColor: "${text.value}",
        );
        _onSave(user);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: background,
                border: Border.all(
                  color: primary,
                  width: 3,
                ),
              ),
              height: 50,
              width: size.width,
              child: Center(
                child: Text("TEXTO", style: TextStyle(color: text)),
              ),
            ),
            Container(
              height: 50,
              color: primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    color: alter,
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: icon,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("TEXTO", style: TextStyle(color: text)),
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
