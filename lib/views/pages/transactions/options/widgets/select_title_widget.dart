import 'package:flutter/material.dart';

class NewTitle extends StatelessWidget {
  final String title;
  const NewTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
