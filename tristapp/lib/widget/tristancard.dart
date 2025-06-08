import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TristanCard extends StatelessWidget {
  final String cardText;
  const TristanCard({super.key, this.cardText = ""});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(cardText), Image(image: Svg('asset/bob.svg'))],
      ),
      // decoration: DecorationImage(image: Svg('assets/bob.svg'))
      // child: Column(children: [Text(cardText), Svg('assets/bob.svg')]),
    );
  }
}
