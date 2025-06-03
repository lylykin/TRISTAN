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
        BinCard(name: stationList?[0].stationName),
        SizedBox(width: 10,),
        BinCard(name: stationList?[1].stationName),
      ],
    );
  }
}
