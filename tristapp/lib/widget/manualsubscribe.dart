import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';

class ManualSubscribe extends StatefulWidget {
  const ManualSubscribe({super.key});

  @override
  State<ManualSubscribe> createState() => ManualSubscribeState();
}

class ManualSubscribeState extends State<ManualSubscribe> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: subscribedNotifier,
      builder: (context, subscribed, child) {
        if (!subscribed) {
          return FilledButton(
            onPressed: () { // Réessaie la liaison de données realtime récupérées sur PocketBase
              subscribedNotifier.value = true;
              subscribeToSparkfun();
              subscribeToObjet();
            },
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(child: Icon(Icons.replay_outlined)),
                  TextSpan(
                    text: "Réésayer la mise à jour en temps réel"
                  ),
                ]
              )
            ),
          );
        } else {
          return RichText(
            text: TextSpan(
              children: [
                WidgetSpan(child: Icon(Icons.check)),
                WidgetSpan(child: SizedBox(width: 20,)),
                TextSpan(
                  text: "Mise à jour en temps réelle fonctionelle",
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                ),
              ]
            )
          );
        }
      }
    );
  }
}