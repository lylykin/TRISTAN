import 'package:flutter/material.dart';
import 'package:tristapp/widget/disconnectbutton.dart';
import 'package:tristapp/widget/manualsubscribe.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: ListTile(
              leading: RichText(
                text: TextSpan(
                  text: "Etat de la liaison temps réel :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
              trailing: ManualSubscribe(),
            )
          ),
          Card(
            color: Theme.of(context).cardColor,
            child: ListTile(
              leading: RichText(
                text: TextSpan(
                  text: "Se déconnecter du serveur PocketBase",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
              trailing: DisconnectButton(),
            )
          )
        ],
      ),
    );
  }
}