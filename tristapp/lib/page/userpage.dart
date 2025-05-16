import 'package:flutter/material.dart';
import 'package:tristapp/widget/usercard.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserCard(refText: "Nom d'utilisafeur : "),
        UserCard(refText: "identifiant : "),
        UserCard(refText: "Score : "),
      ],
    );
  }
}
