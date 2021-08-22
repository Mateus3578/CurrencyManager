import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/models/account_model.dart';

class WalletListTile extends StatelessWidget {
  final onTap;
  final onLongPress;
  final ThemeProvider theme;
  final AccountModel account;

  const WalletListTile({
    required this.theme,
    required this.account,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    String formattedValue = NumberFormat.currency(decimalDigits: 2, symbol: "")
        .format(account.balance);

    return ListTile(
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.wallet_giftcard, //TODO: Mudar para iconId do db
                    color: theme.alterColor,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        account.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(color: theme.textColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Saldo"),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "R\$ $formattedValue",
                    maxLines: 1,
                    style: TextStyle(
                      color: theme.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }
}
