import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*
        FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(45.75762368042102, 4.848624249247964), // Centre la map sur Lyon
            maxZoom: 10
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            ),
          ],
        ),*/
        MapPinInfo(),
      ],
    );
  }
}
