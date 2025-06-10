import 'package:flutter/material.dart';
import 'package:tristapp/widget/lesaviezvous.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TristanCard extends StatelessWidget {
  final String materialId;
  const TristanCard({super.key, required this.materialId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: Svg('assets/bob.svg'))
          ),
        ),
        SizedBox(width: 40),
        LeSaviezVous(materialId: materialId)
      ],
    );
  }
}
