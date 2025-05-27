import 'package:flutter/material.dart';
import 'package:tristapp/page/binitempage.dart';
import 'package:intl/intl.dart';

class ItemShow extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? sparkfunData;

  const ItemShow({super.key, this.index, this.sparkfunData});

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text("Objet affiché n°${widget.index} - ${
          widget.sparkfunData?['record']['updated'] != null
            ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(widget.sparkfunData?['record']['updated'])) // parse converit la chaine, dateformat affiche avec un format lisible
            : "Date inconnue"
          } UTC+0"),
        title: Text(
          widget.sparkfunData != null  // Condition pour éviter d'afficher un objet nul
            ? "Matériau ${widget.sparkfunData?['record']['material']}" // valeur si vrai
            : "Erreur : Objet null" // valeur si faux
        ),
        trailing: Text("Appuyer pour afficher les détails"),
        tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8)
        ), 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BinItemPage(index: widget.index, sparkfunData : widget.sparkfunData)),
          );
        },
      ),
    );
  }
}