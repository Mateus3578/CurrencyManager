import 'package:flutter/material.dart';

class SelectDescWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  /// Informa se precisa de validação ou não. Padrão é sim, precisa validar.
  final bool? validate;
  const SelectDescWidget({
    required this.controller,
    required this.title,
    this.validate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text(title)]),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: title,
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            controller: controller,
            validator: (value) {
              // doidera esse validate == true, mas é para caso dele ser nulo(?)
              // por não ter um valor declarado até ser construído
              if (value!.isEmpty && validate == true) {
                return "Insira uma descrição";
              }
            },
          ),
        ),
      ],
    );
  }
}
