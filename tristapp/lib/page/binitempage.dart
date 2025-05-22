import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';

class BinItemPage extends StatefulWidget {
  final int? index;
  
  const BinItemPage({super.key, this.index});

  @override
  State<BinItemPage> createState() => _BinItemPageState();
}

class _BinItemPageState extends State<BinItemPage> {
  List<double?> gpsData = [0.1, 0.2, 0.3];
  List<int?> sparkfunData = [11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 14];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nom de l'objet - Analyse n°${widget.index}"),
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
            child: ListView.builder(
              itemCount: 3, // Descriptif, données sparkfun, données gps
              itemBuilder: (BuildContext context, int index) {
                return Text("test $index");
              },
            ),
          ),
        ],
      ),
    );
  }
}
