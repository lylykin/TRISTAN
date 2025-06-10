import 'package:flutter/material.dart';
import 'package:tristapp/widget/bincard.dart';

class BinSelectPage extends StatelessWidget {
  final List<dynamic>? stationList;
  const BinSelectPage({super.key, this.stationList});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BinCard(id: stationList?[0].stationId, name: stationList?[0].stationName),
        SizedBox(width: 10,),
        BinCard(id: stationList?[1].stationId, name: stationList?[1].stationName),
      ],
    );
  }
}
