/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  final double? lat;
  final double? long;
  const MapPage({super.key, this.lat, this.long});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  

  @override
  Widget build(BuildContext context) {
    
    MapController mapController = MapController();

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
      decoration: BoxDecoration(
        image: DecorationImage(
          image: mapImg,
          fit: BoxFit.cover
        ),
      ),
      /* 
      FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: LatLng(45.75762368042102, 4.848624249247964), // Centre la map sur Lyon
              maxZoom: 10
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app', // or dev.fleaflet.flutter_map.example maybe ?
              ),
            ],
          ),
          */
      child :Stack(
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
*/


// utilisant geolocator :


/*
 Position? _currentPosition;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
  );

  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    /*
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try requesting permissions again 
        return Future.error('Location permissions are denied');
      }
    }
  
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 
    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    log('Permission : $permission\n');
    // !! Partie du haut non nécessaire sur desktop !!
    */

    log('Location:$_determinePosition');
    try {
      return await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    } catch (e) {
      throw Exception("La géolocalisation n'est pas supportée sur cette plateforme ou non disponible");
    }
    }

  void _getCurrentLocation() async { // fonction asynchrone pour test en parallele
    try {
      Position position = await _determinePosition();
      setState(() {
        _currentPosition = position;
        _locationError = null;
      });
    } catch (e) {
      setState(() {
        _locationError = e.toString();
      });
    }
  } // récupère la localisation ou une erreur en cas de soucis (l'erreur serait venue du code pour mobile)
*/

/*
@override
  Widget build(BuildContext context) {
    
    MapController mapController = MapController();
    return Container(
      child: _locationError != null
        ? Text('Erreur : $_locationError')
        : _currentPosition == null
          ? Text('Location in progress...')
          : Text('Lat:${_currentPosition!.latitude}, Long:${_currentPosition!.longitude}'),
*/