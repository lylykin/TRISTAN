import 'package:flutter/material.dart';
import 'package:tristapp/widget/usercard.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = "Stéphane Delafuente";
    int userId = 4269;
    double score = 2; // A récupérer dans un widget avec state depuis la database
    return Column(
      children: [
        UserCard(refText: "Nom d'utilisafeur : $userName"),
        UserCard(refText: "identifiant : $userId"),
        UserCard(refText: "Score : $score"),
      ],
    );
  }
}
