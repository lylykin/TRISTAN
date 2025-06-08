import 'package:flutter/material.dart';
import 'package:tristapp/page/binpage.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BinCard extends StatelessWidget {
  final String? name;
  const BinCard({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 20, //puts shadowing under the card
        color: Color.fromARGB(255, 149, 214, 151),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  // permet d'afficher l'image dans un widget dont la déco est personalisable
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: Svg(
                        'assets/box.svg',
                      ), //evidemment cette image est provisoire
                    ),
                  ),
                ),
                SizedBox(height: 6),
                FilledButton(
                  onPressed: () {
                    fetchItemsData(); // Mets l'historique à jour automatiquement
                    fetchSparkfunData(); // Mets l'historique à jour automatiquement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BinPage(idBorne: name),
                      ),
                    );
                  },
                  child: Text("Sélectionner la borne"),
                ),
                SizedBox(height: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
