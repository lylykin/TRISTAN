import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';
import 'package:tristapp/widget/linechartobjectsalongtime.dart';
import 'package:tristapp/widget/piechartmaterials.dart';
import 'package:tristapp/widget/piechartrecyclability.dart';
import 'package:tristapp/widget/reloadbutton.dart';

final ValueNotifier<String> chartsToDisplayNotifier = ValueNotifier('materials');

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  void initState() {
    super.initState();
    chartsToDisplayNotifier.value = 'materials'; // Réinitialisation de la page à afficher
  }

  final Map<String, Map<String, dynamic>> chartDisplays = { // Liste des sous pages d'affichage de graphes et leurs propriétés
    'materials' : {
      'pageTitle' : "Matériaux",
      'buttons' : <String>['borneUsage', 'recyclability'],
      'chartsToDisplay' : <StatefulWidget>[
        ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
          valueListenable: itemsHistoryNotifier,
          builder: (context, itemsHistory, child) {
            return PieChartMaterials(itemsHistory: itemsHistory, chartTitle: "Répartition des matériaux analysés");
          }
        ),
        ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
          valueListenable: allUsersItemsHistoryNotifier,
          builder: (context, allUsersItemsHistory, child) {
            return PieChartMaterials(itemsHistory: allUsersItemsHistory, chartTitle: "Matériaux analysés par l'ensemble des utilisateurs");
          }
        ),
      ],
    },
    'recyclability' : {
      'pageTitle' : "Recyclabilité",
      'buttons' : <String>['materials', 'borneUsage'],
      'chartsToDisplay' : <StatefulWidget>[
        ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
          valueListenable: itemsHistoryNotifier,
          builder: (context, itemsHistory, child) {
            return PieChartRecyclability(itemsHistory: itemsHistory, chartTitle: "Pourcentage de matériaux recyclables analysés");
          }
        ),
        ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
          valueListenable: allUsersItemsHistoryNotifier,
          builder: (context, allUsersItemsHistory, child) {
            return PieChartRecyclability(itemsHistory: allUsersItemsHistory, chartTitle: "Matériaux recyclables de l'ensemble des utilisateurs");
          }
        ),
      ]
    },
    'borneUsage' : {
      'pageTitle' : "Utilisation",
      'buttons' : <String>['recyclability', 'materials'],
      'chartsToDisplay' : <StatefulWidget>[
        ValueListenableBuilder<List<Map<String, dynamic>>>( // Reconstrution du widget automatique à chaque changement des data
          valueListenable: itemsHistoryNotifier,
          builder: (context, itemsHistory, child) {
            return LineChartBorneUsage(itemsHistory: itemsHistory, chartTitle: "Utilisation de la borne");
          }
        ),
      ]
    },
  };

  @override
  Widget build(BuildContext context) {
    fetchItemsData();
    fetchAllItemsData(); // Récupération des données utiles pour les graphes

    return ValueListenableBuilder(
      valueListenable: acessToChartsNotifier,
      builder: (context, acessToCharts, child) {
        return ValueListenableBuilder(
          valueListenable: chartsToDisplayNotifier,
          builder: (context, chartsToDisplay, child) {
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: chartDisplays[chartsToDisplayNotifier.value]?['chartsToDisplay']
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => chartsToDisplayNotifier.value = chartDisplays[chartsToDisplayNotifier.value]?['buttons'][0]); // Récupère la première instance de valeur renvoyée par le premier bouton de la sous page
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(Theme.of(context).focusColor)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                text: chartDisplays[chartDisplays[chartsToDisplayNotifier.value]?['buttons'][0]]?['pageTitle'], // Récupère le nom de la page correspondant à la valeur renvoyée par le premier bouton de la sous page
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )
                              )),
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => chartsToDisplayNotifier.value = chartDisplays[chartsToDisplayNotifier.value]?['buttons'][1]); // Récupère la deuxième instance de valeur renvoyée par le deuxième bouton de la sous page
                            },
                            style: ButtonStyle(
                              foregroundColor: WidgetStatePropertyAll(Theme.of(context).focusColor)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                text: chartDisplays[chartDisplays[chartsToDisplayNotifier.value]?['buttons'][1]]?['pageTitle'], // Récupère le nom de la page correspondant à la valeur renvoyée par le deuxième bouton de la sous page
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )
                              )),
                            )
                          ),
                        )
                      ],
                    )
                  ],
                ),            
              ),
            );
          }
        );
      }
    );
  }
}
