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
          return SizedBox.shrink();
        }
      }
    );
  }
}