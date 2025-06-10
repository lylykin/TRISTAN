import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';

class ReloadButton extends StatelessWidget {
  const ReloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () { // Mets à jour les données historiques récupérées sur PocketBase
        fetchItemsData();
      },
      child: Icon(Icons.replay_outlined),
    );
  }
}
