import 'package:flutter/material.dart';
import 'package:tristapp/widget/usercard.dart';
import 'package:tristapp/widget/dynamiclastmesure.dart';

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
        SizedBox(height: 15,),
        RichText(
          text: TextSpan(
          style: DefaultTextStyle.of(context).style, // hérite du style global
          children: [TextSpan(
            text:"Dernière mesure effectuée",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              backgroundColor: Theme.of(context).colorScheme.surface
              ),
            ),]
        )),
        DynamicLastMesure(),
      ],
    );
  }
}
