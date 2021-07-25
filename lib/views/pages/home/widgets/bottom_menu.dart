import 'package:flutter/material.dart';
import 'package:tc/classes/user_preferences.dart';
import 'package:tc/views/custom/navbar_custom_painter.dart';
import 'package:tc/views/pages/transactions/new_transaction.dart';

/// Barra de menu inferior
class BottomMenu extends StatefulWidget {
  final onPressed;

  BottomMenu({required this.onPressed});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = UserPreferences.instance;
    final Size size = MediaQuery.of(context).size;

    List<IconData> _icons = [
      Icons.home,
      Icons.account_balance_wallet,
      Icons.list,
      Icons.settings
    ];

    List<Widget> _navbarItemList = [];

    _navbarItemList.add(navBarItem(0, _icons[0], Colors.black));
    _navbarItemList.add(navBarItem(1, _icons[1], Colors.black));
    _navbarItemList.add(SizedBox(width: size.width * 0.2));
    _navbarItemList.add(navBarItem(2, _icons[2], Colors.black));
    _navbarItemList.add(navBarItem(3, _icons[3], Colors.black));

    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: NavbarCustomPainter(userPreferences.colors["main"]),
          ),
          // Botão central
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => NewTransaction(),
                );
              },
              backgroundColor: userPreferences.colors["main"],
              child: Icon(
                Icons.add,
                size: 35,
                color: Colors.black,
              ),
              elevation: 0.1,
            ),
          ),
          // Outros botões
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _navbarItemList,
            ),
          ),
        ],
      ),
    );
  }

  IconButton navBarItem(int index, IconData iconData, Color color) {
    return IconButton(
      onPressed: () {
        widget.onPressed(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      icon: Icon(iconData),
      color: index == _selectedIndex ? color : color.withAlpha(200),
      iconSize: 30,
    );
  }
}
