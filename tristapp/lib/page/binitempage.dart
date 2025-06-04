import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/widget/lesaviezvous.dart';

class BinItemPage extends StatefulWidget {
  final int? index;
  final List<Map<String, dynamic>?>? sparkfunDataHistory;

  const BinItemPage({super.key, this.index, this.sparkfunDataHistory});

  @override
  State<BinItemPage> createState() => _BinItemPageState();
}

class _BinItemPageState extends State<BinItemPage> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.index ?? 0;
    final materialId =
        widget.sparkfunDataHistory?[index]?['material'] ??
        "Erreur : Objet null";
    return ValueListenableBuilder<Map<String, dynamic>?>(
      valueListenable: itemsDataNotifier,
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
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    AbsorbPointer(
                      // Disables the itemshow widget
                      absorbing: true,
                      child: ItemShow(
                        nullableIndex: widget.index,
                        sparkfunDataHistory: widget.sparkfunDataHistory,
                      ),
                    ),
                    Text("Latitude : ${gpsData?['record']['lat']}"),
                    Text("Longitude : ${gpsData?['record']['long']}"),
                    LeSaviezVous(materialId: materialId),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
