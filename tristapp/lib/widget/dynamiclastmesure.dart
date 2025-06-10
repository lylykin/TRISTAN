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
      builder: (context, sparkfunHistory, child) {
        return ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: itemsDataNotifier,
          builder: (context, itemsData, child) {
            return Placeholder();//ItemShow(nullableIndex: 0, itemsDataHistory : [itemsData]);
            //if (sparkfunDataNotifier.value == null) {
            //  return ItemShow(nullableIndex: 0, sparkfunDataHistory : sparkfunHistory);
            //} else {
            //  return ItemShow(nullableIndex: 0, sparkfunDataHistory : [sparkfunData]);
            //}
          }
        );
      }
    );
  }
}