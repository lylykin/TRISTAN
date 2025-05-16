import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tristapp/page/binpage.dart';

class MapPinInfo extends StatefulWidget {
  final int? lat;
  final int? long;

  const MapPinInfo({super.key, this.lat, this.long});

  @override
  State<MapPinInfo> createState() => _MapPinInfoState();
}

class _MapPinInfoState extends State<MapPinInfo> {
  OverlayPortalController _PinMapOverlayController = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: _PinMapOverlayController.toggle,
      child: OverlayPortal(
        // Crée un widget flottant, déclanché si bind à un pin sur la carte
        controller: _PinMapOverlayController,
        overlayChildBuilder: (BuildContext context) {
          return Positioned(
            top: 50,
            left: 100,
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
                    Text("Nom de la borne"),
                    Text("Coordonnées de la borne"),
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
        child: Icon(Icons.pin_drop),
      ),
    );
  }
}
