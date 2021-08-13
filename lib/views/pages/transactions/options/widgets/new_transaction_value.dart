import 'package:flutter/material.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class NewTransactionValue extends StatelessWidget {
  const NewTransactionValue({required TextEditingController controller})
      : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        controller: _controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Insira um valor";
          }
        },
      ),
    );
  }
}
