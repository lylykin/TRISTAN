import 'package:flutter/material.dart';
import 'package:tristapp/page/binitempage.dart';
import 'package:intl/intl.dart';

class ItemShow extends StatefulWidget {
  final int? nullableIndex;
  final List<Map<String, dynamic>?>? itemsDataHistory;

  const ItemShow({super.key, this.nullableIndex, this.itemsDataHistory});

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {
  @override
  Widget build(BuildContext context) {
    final int index = widget.nullableIndex ?? 0; // Test if null, gives 0 if it is
    final dateItemDisplay = widget.itemsDataHistory?[index]?['updated'] != null // Date à afficher selon la présence de la donnée ou si null
            ? "${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(widget.itemsDataHistory?[index]?['updated']))} UTC +0" // parse converit la chaine, dateformat affiche avec un format lisible
            : "Date inconnue";
    final displayObjectFormat = widget.itemsDataHistory?[index]?['nom_objet'] != null
            ? "Objet "
            : "";
    final objectNameDisplay = widget.itemsDataHistory?[index]?['nom_objet'] ?? "Erreur : Objet null"; // Test if null, error display if it is
    String recyclable;
    if (widget.itemsDataHistory?[index]?['recyclability'] == null) {
      recyclable = "Pas d'information sur la recyclabilité";
    } else {
      if (widget.itemsDataHistory?[index]?['recyclability']) {
        recyclable = "Recyclable";
      } else {
        recyclable = "Non recyclable";
      }
    }

    return Card(
      child: ListTile(
        subtitle: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style, // hérite du style global
            children: [
              TextSpan(
                text: dateItemDisplay,
                style: const TextStyle(fontStyle: FontStyle.italic)
                ),
            ]
          )
        ),
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style, // hérite du style global
            children: [
              TextSpan(text: displayObjectFormat),
              TextSpan(
                text: objectNameDisplay,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ]
          )
        ),
        trailing: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style, // hérite du style global
            children: [TextSpan(
              style: const TextStyle(fontWeight: FontWeight.bold),
              text: recyclable,
              ),
            ],
          ),
        ),
        tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8)
        ), 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BinItemPage(index : widget.nullableIndex, itemsDataHistory: widget.itemsDataHistory)),
          );
        },
      ),
    );
  }
}