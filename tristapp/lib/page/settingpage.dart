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
                    fontSize: 16,
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
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
              trailing: DisconnectButton(),
            )
          ),
          SizedBox(height: 10),
          Card(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  text: "Nous contacter :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                  style : TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary
                  ),
                  children: [
                    TextSpan(
                      text: "     Adresse mail :  ",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        
                      )
                    ),
                    TextSpan(
                      text: "tristanrecyclage@gmail.com",
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 80, 201),
                        decoration: TextDecoration.underline,
                      )
                    )
                  ],
                ),
                
              ),
            )
          )
        ],
      ),
    );
  }
}