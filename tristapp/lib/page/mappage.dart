// import 'dart:developer'; // permet d'utiliser la fonction log pour le debug
import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final List stationList;
  const MapPage({super.key, required this.stationList});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final stationList = widget.stationList;
    final double lat = stationList[0].lat;
    final double long = stationList[0].long; // A remplacer à l'avenir par une attribution automatique des variables selon les différentes bornes données en liste
    final String stationName = stationList[0].stationName;

    MapController mapController = MapController();

    return Container(
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: LatLng(45.75762368042102, 4.848624249247964), // Centre la map sur Lyon
          // minZoom: 7,
          interactionOptions: const InteractionOptions(
            pinchZoomThreshold: 0.2,
          )
          ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app', // or dev.fleaflet.flutter_map.example maybe ?
          ),
          MarkerLayer(markers: [
            Marker(
              width: 30,
              height: 30,
              point: LatLng(lat, long),
              child: MapPinInfo(lat: lat, long: long, stationName: stationName,),
            )
          ]),
        ]
      ),
    );
  }
}
