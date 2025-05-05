import 'package:flutter/material.dart';

class BinCard extends StatelessWidget {
  //issue : I need to resize the card, and to make the icon bigger, or to insert a self-made image for the design.

  const BinCard({super.key});

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
                Image.asset(
                  'assets/trash_img.jpg',
                ), //evidemment cette image est provisoire
                FilledButton(
                  onPressed: ButtonPress,
                  child: Text("Sélectionner la borne"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget ButtonPress() {
  return Text(
    "je suis pressséééé(je ne sers a rien sauf à éviter la fonction)",
  );
}
