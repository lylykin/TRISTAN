import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/data/sensordata.dart';

class BinItemPage extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? sparkfunData;
  
  const BinItemPage({super.key, this.index, this.sparkfunData});

  @override
  State<BinItemPage> createState() => _BinItemPageState();
}

class _BinItemPageState extends State<BinItemPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: gpsDataNotifier,
      builder: (context, gpsData, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Détails de l'objet"),
            centerTitle: true,
            foregroundColor: Theme.of(context).colorScheme.primary,
            elevation: 10,
            scrolledUnderElevation: 50,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Returnbutton(),
              )
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    ItemShow(index: widget.index, sparkfunData : widget.sparkfunData), // BUG Renvoie sur la même page indéfiniment, utiliser une autre solution d'affichage !
                    Text("Latitude : ${gpsData?['record']['lat']}"),
                    Text("Longitude : ${gpsData?['record']['long']}")
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
