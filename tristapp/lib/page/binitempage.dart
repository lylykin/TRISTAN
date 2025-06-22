import 'package:flutter/material.dart';
import 'package:tristapp/widget/returnbutton.dart';
import 'package:tristapp/widget/itemshow.dart';
import 'package:tristapp/widget/tristancard.dart';

class BinItemPage extends StatefulWidget {
  final int? index;
  final List<Map<String, dynamic>?>? itemsDataHistory;

  const BinItemPage({super.key, this.index, this.itemsDataHistory});

  @override
  State<BinItemPage> createState() => _BinItemPageState();
}

class _BinItemPageState extends State<BinItemPage> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.index ?? 0;
    final materialId =
        widget.itemsDataHistory?[index]?['materiau'] ??
        "Non identifié";
    final Map<String, dynamic> gps = (widget.itemsDataHistory?[index]?['expand']['sparkfun_via_objet'] != null)
      ? widget.itemsDataHistory?[index]?['expand']['sparkfun_via_objet'][0]['expand']['borne'] // Une seule mesure par objet donc [0] séléctionne l'unique valeur de la liste 'sparkfun_via_objet'
      : {'lat_actuel' : null, 'long_actuel' : null};
    String latDisplay = (gps['lat_actuel'] == null || gps['lat_actuel'] == "") ? "Aucune donnée" : gps['lat_actuel'];
    String longDisplay = (gps['long_actuel'] == null || gps['long_actuel'] == "") ? "Aucune donnée" : gps['long_actuel'];

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
                    itemsDataHistory: widget.itemsDataHistory,
                  ),
                ),
                SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    text: "Matériau détecté : ${(materialId == null || materialId == "") ?"Aucune donnée" : materialId}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                      shadows: [Shadow(color: Theme.of(context).colorScheme.secondary, blurRadius: 40)]
                    ),
                  )
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Coordonnées de la borne",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  )
                ),
                RichText(
                  text: TextSpan(
                    text: "Latitude : $latDisplay",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  )
                ),
                RichText(
                  text: TextSpan(
                    text: "Longitude : $longDisplay",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  )
                ),
                SizedBox(height: 30),
                TristanCard(materialId: materialId),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
