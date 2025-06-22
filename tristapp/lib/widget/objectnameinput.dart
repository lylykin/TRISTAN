import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/widget/objectnameinputdialog.dart';

class ObjectNameInput extends StatefulWidget {
  const ObjectNameInput({super.key});

  @override
  State<ObjectNameInput> createState() => _ObjectNameInputState();
}

class _ObjectNameInputState extends State<ObjectNameInput> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: displayInputObjectNotifier,
      builder: (context, displayInputObject, child) {
        if (displayInputObject) {
          return ValueListenableBuilder<String?>(
            valueListenable: inputObjectNotifier,
            builder: (context, inputObject, child) {
              return ObjectNameInputDialog(
                onSubmitted: (input) { // Fonction callback
                  inputObjectNotifier.value = input; //Traitement de la valeur entrée
                  displayInputObjectNotifier.value = false; // Fin de l'affichage widget dialog
                },
              );
            }
          );
        } else {
          return RichText(
            text: TextSpan(
              text: "Insérez un objet dans la borne pour commencer la mesure",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                shadows: [Shadow(color: Theme.of(context).shadowColor, blurRadius: 15)]
              )
            )
          );
        }
      }
    );
  }
}