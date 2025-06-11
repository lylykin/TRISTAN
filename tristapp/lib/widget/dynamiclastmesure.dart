import 'package:flutter/widgets.dart';
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
              return ItemShow(nullableIndex: 0, itemsDataHistory : [itemsData]);
            } else {
              if (itemsHistory.isNotEmpty) {
                return ItemShow(nullableIndex: 0, itemsDataHistory : itemsHistory);
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