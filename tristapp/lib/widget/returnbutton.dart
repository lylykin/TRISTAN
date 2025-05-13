import 'package:flutter/material.dart';

class Returnbutton extends StatelessWidget {
  const Returnbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Retour'),
    );
  }
}
