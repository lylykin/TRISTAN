import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/binpage.dart';

class MapPinOverlay extends StatelessWidget {
  final dynamic station;

  const MapPinOverlay({super.key, this.station});

  @override
  Widget build(BuildContext context) {
    return Positioned(
          top: 50,
          left: 150,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Besoin de changer les couleurs du texte !
                  Text(
                    station.stationName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Latitude : ${station.lat}\nLongitude : ${station.long}",
                  ),
                  SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {
                      fetchItemsData(); // Mets l'historique à jour automatiquement
                      fetchSparkfunData(); // Mets l'historique à jour automatiquement
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BinPage(idBorne : station.stationName)),
                      );
                    },
                    child: Text("Accéder à la borne"),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}