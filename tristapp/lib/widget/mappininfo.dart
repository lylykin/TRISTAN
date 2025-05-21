import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:tristapp/page/binpage.dart';

class MapPinInfo extends StatefulWidget {
  final double? lat;
  final double? long;
  final String? stationName;

  const MapPinInfo({super.key, this.lat, this.long, this.stationName});

  @override
  State<MapPinInfo> createState() => _MapPinInfoState();
}

class _MapPinInfoState extends State<MapPinInfo> {
  final OverlayPortalController _pinMapOverlayController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    final double? lat = widget.lat;
    final double? long = widget.long;
    final String? stationName = widget.stationName;
    return OverlayPortal(
        // Crée un widget flottant, déclanché si bind à un pin sur la carte
        controller: _pinMapOverlayController,
        overlayChildBuilder: (BuildContext context) {
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
                    Text(stationName.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Latitude : $lat\nLongitude : $long"),
                    SizedBox(height: 10,),
                    FilledButton(
                      onPressed: () {
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
        child : FilledButton(
          onPressed: _pinMapOverlayController.toggle,
          style: FilledButton.styleFrom(
            padding: EdgeInsets.zero,  // pas de padding interne
          ),
          child:  Icon(Icons.pin_drop),
      ), 
    );
  }
}
