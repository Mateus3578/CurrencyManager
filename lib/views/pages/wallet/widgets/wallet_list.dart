import 'package:flutter/material.dart';
import 'package:tc/controllers/theme_provider.dart';
import 'package:tc/views/pages/wallet/widgets/wallet_list_tile.dart';

class WalletList extends StatelessWidget {
  /// Lista de itens a serem exibidos
  final List accounts;

  /// Controlador do scroll
  final ScrollController scrollController;
  final ThemeProvider theme;
  final bool isLoading;

  const WalletList({
    required this.accounts,
    required this.scrollController,
    required this.theme,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(0, height * 0.27, 0, 0),
      child: accounts.isNotEmpty && !isLoading
          ? ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.12),
              controller: scrollController,
              itemCount: accounts.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    WalletListTile(
                      account: accounts[index],
                      theme: theme,
                      onTap: () {
                        // TODO: Carregar dados da conta
                        // https://stackoverflow.com/questions/60555572/is-there-a-way-to-autofill-a-textformfield-when-a-button-is-pressed-in-flutter
                      },
                    ),
                    Divider(color: theme.textColor.withAlpha(50)),
                  ],
                );
              },
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              ),
            ),
    );
  }
}
//TODO: Se por algum motivo não conseguir puxar nada do db, avisar invés de ficar rodando infinitamente

//TODO: Organizar contas por mês