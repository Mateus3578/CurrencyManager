import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class SelectValueWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  // Desenha uma borda
  final bool? drawBorder;
  const SelectValueWidget({
    required this.controller,
    required this.title,
    this.drawBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text(title)]),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              CurrencyTextInputFormatter(
                locale: "pt-br",
                decimalDigits: 2,
                symbol: "R\$",
              ),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "R\$0,00",
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "Insira um valor";
              }
            },
          ),
        ),
      ],
    );
  }
}
