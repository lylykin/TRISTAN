import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String refText;
  final IconData icon;

  const UserCard({super.key, this.refText = "", this.icon = Icons.account_circle_outlined});
  //issue :reftext isnt an argument, i have to search how to do it?

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: ListTile(
        leading: Icon(icon),
        title: Text(refText),
      ),
    );
  }
}
