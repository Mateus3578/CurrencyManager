import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tc/views/pages/home/transactions/transaction_list_tile.dart';

class TransactionList extends StatelessWidget {
  /// Lista de itens a serem exibidos
  final List items;

  /// Controlador do scroll
  final ScrollController scrollController;

  final Color textColor;
  final Color primaryColor;

  const TransactionList({
    Key? key,
    required this.items,
    required this.scrollController,
    required this.textColor,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(0, height * 0.27, 0, 0),
      child: items.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.12),
              controller: scrollController,
              itemCount: items.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return TransactionListTile(
                  type: items[index].type,
                  description: items[index].description,
                  value: items[index].value,
                  textColor: textColor,
                  onTap: () {
                    // TODO: Carregar alterar despesa escolhida
                  },
                );
              },
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            ),
    );
  }
}
//TODO: Se por algum motivo não conseguir puxar nada do db, avisar invés de ficar rodando infinitamente

//TODO: Organizar transações por data e mês