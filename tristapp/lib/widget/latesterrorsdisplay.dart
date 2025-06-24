import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';

class LatestErrorsDisplay extends StatelessWidget {
  const LatestErrorsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: latestPocketbaseErrorListNotifier,
      builder: (context, latestPocketbaseErrorList, child) {
        return (latestPocketbaseErrorList.isNotEmpty) 
        ? Card(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                    text: "Dernières erreurs PocketBase :",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )
                  )),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      itemCount: latestPocketbaseErrorList.length, // Nombre d'erreurs à display
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          trailing: Text("Error n°$index"),
                          title: Text(
                            latestPocketbaseErrorList[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.error
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        );
                      },
                    ),
                  ),
                ],
                        ),
            ),
        )
        : SizedBox.shrink();
      }
    );
  }
}