// import 'dart:developer'; // permet d'utiliser la fonction log pour le debug
import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/binpage.dart';

class MapPage extends StatefulWidget {
  final List
  stationList; // liste de tuples de la forme (lat : double, long : double, stationName : String)
  const MapPage({super.key, required this.stationList});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  OverlayPortalController pinOverlayController = OverlayPortalController();
  int? selectedPinIndex;
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final stationList = widget.stationList;
    List<Marker> markersList = [];

    for (
      int stationIndex = 0;
      stationIndex < stationList.length;
      stationIndex++
    ) {
      dynamic lat = stationList[stationIndex].lat;
      dynamic long = stationList[stationIndex].long;
      markersList.add(
        Marker(
          // Création d'un widget marker pour chaque instance de la liste en entrée de mappage
          width: 30,
          height: 30,
          point: LatLng(lat, long),
          child: FilledButton(
            onPressed: () {
              setState(() {
                if (selectedPinIndex != stationIndex) {
                  selectedPinIndex = stationIndex;
                  pinOverlayController
                      .show(); // Affichage de l'overlay (pin appuyé donc overlay non placeholder)
                } else {
                  selectedPinIndex = null;
                  pinOverlayController.hide(); // Overlay caché
                }
              });
            },
            style: FilledButton.styleFrom(
              padding: EdgeInsets.zero, // pas de padding interne
            ),
            child: Icon(Icons.pin_drop),
            //key: stationName,
          ),
        ),
      );
    }

    return OverlayPortal(
      controller: pinOverlayController,
      overlayChildBuilder: (context) {
        if (selectedPinIndex == null) return SizedBox.shrink();
        final station =
            stationList[selectedPinIndex!]; // Considéré non null car test renvoyant un overlay vide si aucun pin séléctionné
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
                      fetchGpsData(); // Mets l'historique à jour automatiquement
                      fetchSparkfunData(); // Mets l'historique à jour automatiquement
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BinPage()),
                      );
                    },
                    child: Text("Accéder à la borne"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(
            45.75762368042102,
            4.848624249247964,
          ), // Centre la map sur Lyon
          minZoom: 2,
          interactionOptions: const InteractionOptions(pinchZoomThreshold: 0.2),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'com.example.app', // or dev.fleaflet.flutter_map.example maybe ?
          ),
          MarkerLayer(markers: markersList),
        ],
      ),
    );
  }
}

double doubleConvert(value) {
  // function used to convert
  var type = value.runtimeTime;
  if (type != double) {
    value.toInt();
  }
  return (value);
}
