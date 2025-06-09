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
      valueListenable: sparkfunHistoryNotifier,
      builder: (context, sparkfunHistory, child) {
        return ValueListenableBuilder<Map<String, dynamic>?>(
          valueListenable: sparkfunDataNotifier,
          builder: (context, sparkfunData, child) {
            return ItemShow(nullableIndex: 0, sparkfunDataHistory : [sparkfunData]);
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