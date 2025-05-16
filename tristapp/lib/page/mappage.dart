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
    final Size containerSize = MediaQuery.of(context).size;
    AssetImage mapImg = AssetImage("assets/map.png");
    const double imageWidth = 1407;
    const double imageHeight = 1048; // A remplacer manuellement selon mapImg
    const double imageRatio = imageWidth/imageHeight;
    final double containerRatio = containerSize.width/containerSize.height;

    double displayHeight, displayWidth, offsetX = 0, offsetY = 0;
    if (containerRatio > imageRatio) {
    // L'image est coupée en haut/bas
      displayWidth = containerSize.width;
      displayHeight = containerSize.width / imageRatio;
      offsetY = (containerSize.height - displayHeight) / 2;
    } else {
      // L'image est coupée à gauche/droite
      displayHeight = containerSize.height;
      displayWidth = containerSize.height * imageRatio;
      offsetX = (containerSize.width - displayWidth) / 2;
    }

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
        image: DecorationImage(
          image: mapImg,
          fit: BoxFit.cover
        ),
      ),
      child: Stack(
        children: [
          if (lat != null && long != null)
            Positioned(
              top: -offsetY + (lat!*imageHeight),
              left: -offsetX + (long!*imageWidth),
              child: MapPinInfo()
            ),
        ],
      ),
    );
  }
}
