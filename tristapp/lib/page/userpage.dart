import 'package:flutter/material.dart';
import 'package:tristapp/widget/usercard.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserCard("Nom d'utilisafeur"),
        Text("identifiant : "),
        Text("Score"),
      ],
    );
  }
}
