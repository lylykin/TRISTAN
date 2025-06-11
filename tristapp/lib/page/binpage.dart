import 'package:flutter/material.dart';
import 'package:tristapp/widget/reloadbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';

// Liaison dynamique à implémenter (sur les widgets child également)

class BinPage extends StatelessWidget {
  final String? idBorne;
  final String? nomBorne;
  const BinPage({super.key, this.idBorne, this.nomBorne});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>?>>(
      valueListenable: itemsHistoryNotifier,
      builder: (context, itemsDataHistory, child) {
        List<Map<String, dynamic>> itemsNameStationDataHistory = [];
          for (Map<String, dynamic>? record in itemsDataHistory) {
            if ( // Récupère toutes les données non null, provenant de la borne séléctionnée, étant de la phase 2 (objet!=null) (déjà traitée pour l'utilisateur courant)
              record!['expand']['sparkfun_via_objet'] != null &&
              record!['expand']['sparkfun_via_objet'][0]['borne'] == idBorne // [0] car normalement une seule mesure par objet donc pas besoin de parcourir la liste
            ) { 
              itemsNameStationDataHistory.add(record); // On ajoute les données objet liées à tous les objets de l'user pour la borne (contenant sparkfun dans le expand)
            }
                
            }
        return Scaffold(
          appBar: AppBar(
            title: Text("Poubelle $nomBorne"),
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
                  itemCount: itemsNameStationDataHistory.length, // Nombre de lignes dans Pocketbase pour les mesures sparkfun
                  itemBuilder: (BuildContext context, int index) {
                    return ItemShow(nullableIndex: index, itemsDataHistory : itemsNameStationDataHistory);
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
