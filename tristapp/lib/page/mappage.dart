import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  final double? lat;
  final double? long;
  const MapPage({super.key, this.lat, this.long});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/map.png")),
      ),
      child: Stack(
        children: [
          Positioned(top: lat, left: long, child: MapPinInfo()),
          // Positioned(top: lat, left: long, child: MapPinInfo()),
        ],
      ),
    );
  }
}
