import 'package:flutter/material.dart';
import 'package:tristapp/widget/reloadbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';
import 'package:tristapp/widget/searchbar.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class DataListPage extends StatefulWidget {
  const DataListPage({super.key});

  @override
  State<DataListPage> createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  List<Map<String, dynamic>>? filteredList;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: acessToChartsNotifier,
      builder: (context, acessToCharts, child) {
        return ValueListenableBuilder<List<Map<String, dynamic>?>>(
          valueListenable: itemsHistoryNotifier,
          builder: (context, itemsDataHistory, child) {
            final itemsToDisplay = filteredList ?? itemsDataHistory;
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
                  DataSearchBar(
                    itemsList: itemsDataHistory, 
                    onSearchResult: (result) {
                      setState(() {
                        filteredList = result;
                      });
                    },
                    onCancelModifyers: () {
                      setState(() {
                        filteredList = null;
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: itemsToDisplay.length, // Nombre de lignes dans Pocketbase pour les mesures sparkfun
                      itemBuilder: (BuildContext context, int index) {
                        return ItemShow(nullableIndex: index, itemsDataHistory : itemsToDisplay);
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
