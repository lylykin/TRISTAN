import 'package:flutter/material.dart';
import 'package:tristapp/widget/aucunresultatdisplay.dart';
import 'package:tristapp/widget/reloadbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/widget/searchbar.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class BinPage extends StatefulWidget {
  final String? idBorne;
  final String? nomBorne;
  const BinPage({super.key, this.idBorne, this.nomBorne});

  @override
  State<BinPage> createState() => _BinPageState();
}

class _BinPageState extends State<BinPage> {
  List<Map<String, dynamic>>? filteredList;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>?>>(
      valueListenable: itemsHistoryNotifier,
      builder: (context, itemsDataHistory, child) {
        List<Map<String, dynamic>> itemsNameStationDataHistory = [];
        for (Map<String, dynamic>? record in itemsDataHistory) {
          if ( // Récupère toutes les données non null, provenant de la borne séléctionnée, étant de la phase 2 (objet!=null) (déjà traitée pour l'utilisateur courant)
            record!['expand']['sparkfun_via_objet'] != null &&
            record['expand']['sparkfun_via_objet'][0]['borne'] == widget.idBorne // [0] car normalement une seule mesure par objet donc pas besoin de parcourir la liste
          ) { 
            itemsNameStationDataHistory.add(record); // On ajoute les données objet liées à tous les objets de l'user pour la borne (contenant sparkfun dans le expand)
          }   
        }

        List<Map<String, dynamic>?> itemsToDisplay = filteredList ?? itemsNameStationDataHistory;
        
        return Scaffold(
          appBar: AppBar(
            title: Text("Poubelle ${widget.nomBorne}"),
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
              DataSearchBar(
                itemsList: itemsNameStationDataHistory, 
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
                child: (itemsToDisplay.isNotEmpty) 
                  ? ListView.builder(
                      itemCount: itemsToDisplay.length, // Nombre de lignes dans Pocketbase pour les mesures sparkfun
                      itemBuilder: (BuildContext context, int index) {
                        return ItemShow(nullableIndex: index, itemsDataHistory : itemsToDisplay);
                      },
                    )
                  : AucunResultatDisplay()
              ),
            ],
          ),
        );
      }
    );
  }
}
