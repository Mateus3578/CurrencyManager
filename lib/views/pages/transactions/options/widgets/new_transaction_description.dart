import 'package:flutter/material.dart';

class NewTransactionDescription extends StatelessWidget {
  const NewTransactionDescription({
    Key? key,
    required TextEditingController controller,
  })  : _descriptionController = controller,
        super(key: key);

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        controller: _descriptionController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Insira uma descrição";
          }
        },
      ),
    );
  }
}
