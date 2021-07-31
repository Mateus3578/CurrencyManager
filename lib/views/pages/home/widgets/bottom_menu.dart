import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/custom/navbar_custom_painter.dart';
import 'package:tc/views/pages/transactions/new_transaction.dart';

/// Barra de menu inferior
class BottomMenu extends StatefulWidget {
  final ThemeProvider theme;
  final onPressed;

  BottomMenu({
    required this.theme,
    required this.onPressed,
  });

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Ícones do menu
    List<IconData> _icons = [
      Icons.home,
      Icons.account_balance_wallet,
      Icons.list,
      Icons.settings
    ];

    return Container(
      width: size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: NavbarCustomPainter(widget.theme.primaryColor),
          ),
          // Botão central
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              elevation: 0.1,
              backgroundColor: widget.theme.alterColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => NewTransaction(widget.theme),
                );
              },
              child: Icon(
                Icons.add,
                size: 35,
                color: widget.theme.iconColor,
              ),
            ),
          ),
          // Outros botões
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                navBarItem(0, _icons[0]),
                navBarItem(1, _icons[1]),
                SizedBox(width: size.width * 0.2),
                navBarItem(2, _icons[2]),
                navBarItem(3, _icons[3]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconButton navBarItem(int index, IconData iconData) {
    return IconButton(
      onPressed: () {
        widget.onPressed(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      splashColor: Colors.transparent,
      splashRadius: 0.1,
      color: widget.theme.iconColor,
      icon: Icon(iconData),
      iconSize: index == _selectedIndex ? 34 : 26,
    );
  }
}
