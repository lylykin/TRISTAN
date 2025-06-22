import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/widget/itemshow.dart';

class DynamicLastMesure extends StatefulWidget {
  const DynamicLastMesure({super.key});

  @override
  State<DynamicLastMesure> createState() => _DynamicLastMesureState();
}

class _DynamicLastMesureState extends State<DynamicLastMesure> {
  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder<List<Map<String, dynamic>?>>(
      valueListenable: itemsHistoryNotifier,
      builder: (context, itemsHistory, child) {
        return ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: itemsDataNotifier,
          builder: (context, itemsData, child) {
            if (itemsData != null) {
              return Column(
                children: [
                  RichText(
                    text: TextSpan(
                    style: DefaultTextStyle.of(context).style, // hérite du style global
                    children: [TextSpan(
                      text:"Dernière mesure effectuée :",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceBright,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        shadows: [Shadow(blurRadius: 15), Shadow(blurRadius: 30)]
                        ),
                      ),]
                  )),
                  SizedBox(height: 10,),
                  ItemShow(nullableIndex: 0, itemsDataHistory : [itemsData]),
                ],
              );
            } else {
              if (itemsHistory.isNotEmpty) {
                return Column(
                  children: [
                    RichText(
                      text: TextSpan(
                      style: DefaultTextStyle.of(context).style, // hérite du style global
                      children: [TextSpan(
                        text:"Dernière mesure effectuée :",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surfaceBright,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          shadows: [Shadow(blurRadius: 15), Shadow(blurRadius: 30)]
                          ),
                        ),]
                    )),
                    SizedBox(height: 10,),
                    ItemShow(nullableIndex: 0, itemsDataHistory : itemsHistory),
                  ],
                );
              } else {
                return SizedBox.shrink(); // Si la connexion pocketbase pas encore effectuée ou la récupération d'objets encore en cours (évite le plantage)
              }
            }
//ItemShow(nullableIndex: 0, itemsDataHistory : [itemsData]);

          }
        );
      }
    );
  }
}