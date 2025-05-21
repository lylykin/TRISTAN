import 'package:flutter/material.dart';
import 'package:tristapp/page/binitempage.dart';

class ItemShow extends StatelessWidget {
  int? index;

  ItemShow({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Text("Objet analysé n°$index"),
        title: Text("Nom de l'objet"),
        trailing: Text("Appuyer pour afficher les détails"),
        tileColor: Theme.of(context).colorScheme.surface,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BinItemPage(index: index)),
          );
        },
      ),
    );
  }
}