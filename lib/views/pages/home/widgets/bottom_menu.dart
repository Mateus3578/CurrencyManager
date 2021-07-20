import 'package:flutter/material.dart';
import 'package:tc/classes/app_colors.dart';
import 'package:tc/views/custom/navbar_custom_painter.dart';
import 'package:tc/views/pages/home/home.dart';
import 'package:tc/views/pages/home/transactions/monthly_transactions.dart';
import 'package:tc/views/pages/settings/settings.dart';
import 'package:tc/views/pages/transactions/new_transaction.dart';

//TODO: PageView (ou algo parecido) entre as opções principais do menu
//TODO: Trocar Navigation para PageView

/// Barra de menu inferior
class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppColors appColors = AppColors.instance;
    final Size size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(size.width, 80),
              painter: NavbarCustomPainter(appColors.colors["main"]),
            ),
            // Botão de adicionar transações
            Center(
              heightFactor: 0.6,
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => NewTransaction(),
                  );
                },
                backgroundColor: appColors.colors["main"],
                child: Icon(
                  Icons.add,
                  size: 35,
                ),
                elevation: 0.1,
              ),
            ),
            Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Menu principal
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                    icon: Icon(Icons.home),
                    color: Colors.black,
                    iconSize: 30,
                  ),
                  // Contas
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.account_balance_wallet),
                    color: Colors.black,
                    iconSize: 30,
                  ),
                  //Espaçamento
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  // Lista de transações
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonthlyTransactions(),
                        ),
                      );
                    },
                    icon: Icon(Icons.list),
                    color: Colors.black,
                    iconSize: 30,
                  ),
                  // Configurações
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Settings(),
                        ),
                      );
                    },
                    icon: Icon(Icons.settings),
                    color: Colors.black,
                    iconSize: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
