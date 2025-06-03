import 'package:flutter/material.dart';
import 'package:tristapp/widget/reloadbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>?>>(
      valueListenable: sparkfunHistoryNotifier,
      builder: (context, sparkfunDataHistory, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Données mesurées"),
            centerTitle: true,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 10,
            scrolledUnderElevation: 50,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReloadButton(),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: sparkfunDataHistory.length, // Nombre de lignes dans Pocketbase pour les mesures sparkfun
                  itemBuilder: (BuildContext context, int index) {
                    return ItemShow(nullableIndex: index, sparkfunDataHistory : sparkfunDataHistory);
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
