// import 'dart:developer'; // permet d'utiliser la fonction log pour le debug
import 'package:flutter/material.dart';
import 'package:tristapp/widget/mapdisplay.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tristapp/widget/mappinoverlay.dart';

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
    
    for ( // Création d'un widget marker pour chaque instance de la liste en entrée de mappage (avec lien overlay)
      int stationIndex = 0;
      stationIndex < stationList.length;
      stationIndex++
    ) {
      dynamic lat = stationList[stationIndex].lat;
      dynamic long = stationList[stationIndex].long;
      markersList.add(
        Marker(
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
        if (selectedPinIndex == null) return SizedBox.shrink(); // Cas aucun widget séléctionné
        return MapPinOverlay(
          station: stationList[selectedPinIndex!] // Considéré non null car test renvoyant un overlay vide si aucun pin séléctionné
        );
      },
      child: MapDisplay(mapController: mapController, markersList: markersList)
    );
  }
}

double doubleConvert(dynamic value) {
  // function used to convert
  var type = value.runtimeType;
  if (type != double) {
    return value.toDouble();
  }
  return (value);
}

//DEBUG
//Future<void> main() async {
//  int val = 4;
//  print(doubleConvert(val));
//}