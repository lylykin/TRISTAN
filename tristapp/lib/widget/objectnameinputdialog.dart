import 'package:flutter/material.dart';

class ObjectNameInputDialog extends StatefulWidget {
  final void Function(String)? onSubmitted; // Fonction callback pour le widget
  const ObjectNameInputDialog({super.key, this.onSubmitted});

  @override
  State<ObjectNameInputDialog> createState() => _ObjectNameInputDialogState();
}

class _ObjectNameInputDialogState extends State<ObjectNameInputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (contextDialog) => AlertDialog(
        title: const Text("Entrez le nom de l'objet à scanner"),
        content : TextField(
          controller : _controller,
          decoration : const InputDecoration(hintText: "Laissez vide pour ne pas sauvegarder"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (widget.onSubmitted != null) widget.onSubmitted!(""); // Renvoie ""
            },
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.onSubmitted != null) widget.onSubmitted!(_controller.text); // Renvoie la valeur
            },
            child: const Text("Valider")
          ),
        ]
      ),
    );
  }
}