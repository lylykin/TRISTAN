import 'package:flutter/material.dart';
import 'package:tristapp/main.dart';
import 'package:tristapp/data/sensordata.dart';

class DisconnectButton extends StatelessWidget {
  const DisconnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
            onPressed: () { // Supprime le statut connecté et libère les informations de connexion
              isLoggedInNotifier.value = false;
              pb.authStore.clear();
            },
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.cancel)),
                  WidgetSpan(child: SizedBox(width: 10)),
                  TextSpan(
                    text: "Déconnexion"
                  ),
                ]
              )
            ),
          );
  }
}