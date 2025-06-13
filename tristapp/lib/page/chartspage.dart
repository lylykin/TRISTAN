import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';
import 'package:tristapp/widget/piechartmaterials.dart';
import 'package:tristapp/widget/reloadbutton.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: acessToChartsNotifier,
      builder: (context, acessToCharts, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Statistiques"),
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
                  child: Text("Données brutes")
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReloadButton(),
              )
            ],
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
                  valueListenable: itemsHistoryNotifier,
                  builder: (context, itemsHistory, child) {
                    return PieChartMaterials(itemsHistory: itemsHistory);
                  }
                ),
                ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
                  valueListenable: allUsersItemsHistoryNotifier,
                  builder: (context, allUsersItemsHistory, child) {
                    return PieChartMaterials(itemsHistory: allUsersItemsHistory);
                  }
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
