import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';

class BinItemPage extends StatelessWidget {
  List<double?> gpsData = [0.1, 0.2, 0.3];
  List<int?> sparkfunData = [11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 14];
  int? index;
  
  BinItemPage({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nom de l'objet - Analyse n°$index"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
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
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: 3, // Descriptif, données sparkfun, données gps
                itemBuilder: (BuildContext context, int index) {
                  return Text("test $index");
                },
              ),
            )
          ),
        ],
      ),
    );
  }
}
