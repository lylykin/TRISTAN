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
        UserCard(refText: "Nom d'utilisateur : $userName", icon : Icons.perm_identity),
        UserCard(refText: "identifiant : $userId", icon : Icons.account_tree_outlined),
        ValueListenableBuilder(
          valueListenable : nObjectScannedUserNotifier,
          builder : (context, nObjectScannedUser, child) {
            return UserCard(refText: "Score : $nObjectScannedUser", icon : Icons.analytics_outlined); // Le score équivaut au nombre d'objets différents scannés par l'utilisateur
          }
        ),
        SizedBox(height: 15),
        DynamicLastMesure(),
        SizedBox(height: 15),
        ObjectNameInput(),
      ],
    );
  }
}
