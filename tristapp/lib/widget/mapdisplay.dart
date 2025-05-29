import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDisplay extends StatelessWidget {
  final MapController mapController;
  final List<Marker> markersList;
  const MapDisplay({super.key, required this.mapController, required this.markersList});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
    );
  }
}