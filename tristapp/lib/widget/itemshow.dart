import 'package:flutter/material.dart';
import 'package:tristapp/page/binitempage.dart';

class ItemShow extends StatefulWidget {
  final int? index;

  const ItemShow({super.key, this.index});

  @override
  State<ItemShow> createState() => _ItemShowState();
}

class _ItemShowState extends State<ItemShow> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text("Objet analysé n°${widget.index}"),
        title: Text("Nom de l'objet"),
        trailing: Text("Appuyer pour afficher les détails"),
        tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8)
        ), 
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BinItemPage(index: widget.index)),
          );
        },
      ),
    );
  }
}