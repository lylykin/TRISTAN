import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String refText;

  const UserCard({super.key, this.refText = ""});
  //issue :reftext isnt an argument, i have to search how to do it?

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 205, 248, 156),
      child: ListTile(
        leading: Icon(Icons.account_circle_outlined),
        title: Text(refText),
      ),
    );
  }
}
