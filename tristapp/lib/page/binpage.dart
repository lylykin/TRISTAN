import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class BinPage extends StatelessWidget {
  const BinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: sparkfunDataNotifier,
      builder: (context, sparkfunData, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Poubelle Tristan"),
            centerTitle: true,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 10,
            scrolledUnderElevation: 50,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Returnbutton(),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 20, // Nombre de données captées (doit être lié dynamiquement)
                  itemBuilder: (BuildContext context, int index) {
                    return ItemShow(index: index, sparkfunData : sparkfunData);
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
