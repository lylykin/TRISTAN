import 'package:flutter/material.dart';
import 'package:tristapp/widget/usercard.dart';
import 'package:tristapp/widget/dynamiclastmesure.dart';
import 'package:tristapp/widget/objectnameinput.dart';
import 'package:tristapp/data/sensordata.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = (pb.authStore.record!.data['name'].isNotEmpty)
      ? pb.authStore.record!.data['name']
      : "Aucun nom d'utilisateur";
    String userId = pb.authStore.record?.data['id'];
    
    return Column(
      children: [
        UserCard(refText: "Nom d'utilisateur : $userName"),
        UserCard(refText: "identifiant : $userId"),
        ValueListenableBuilder(
          valueListenable : nObjectScannedUserNotifier,
          builder : (context, nObjectScannedUser, child) {
            return UserCard(refText: "Score : $nObjectScannedUser"); // Le score équivaut au nombre d'objets différents scannés par l'utilisateur
          }
        ),
        SizedBox(height: 15),
        RichText(
          text: TextSpan(
          style: DefaultTextStyle.of(context).style, // hérite du style global
          children: [TextSpan(
            text:"Dernière mesure effectuée :",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surfaceBright,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              shadows: [Shadow(blurRadius: 15), Shadow(blurRadius: 30)]
              ),
            ),]
        )),
        SizedBox(height: 10,),
        DynamicLastMesure(),
        ObjectNameInput(),
      ],
    );
  }
}
