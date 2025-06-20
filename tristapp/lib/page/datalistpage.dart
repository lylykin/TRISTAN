import 'package:flutter/material.dart';
import 'package:tristapp/widget/reloadbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class DataListPage extends StatelessWidget {
  const DataListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: acessToChartsNotifier,
      builder: (context, acessToCharts, child) {
        return ValueListenableBuilder<List<Map<String, dynamic>?>>(
          valueListenable: itemsHistoryNotifier,
          builder: (context, itemsDataHistory, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Données mesurées (toutes bornes)"),
                centerTitle: true,
                foregroundColor: Theme.of(context).colorScheme.primary,
                elevation: 10,
                scrolledUnderElevation: 50,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        acessToChartsNotifier.value = !acessToChartsNotifier.value;
                      },
                      child: Text("Graphiques")
                    ),
                  ),
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
                      itemCount: itemsDataHistory.length, // Nombre de lignes dans Pocketbase pour les mesures sparkfun
                      itemBuilder: (BuildContext context, int index) {
                        return ItemShow(nullableIndex: index, itemsDataHistory : itemsDataHistory);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
