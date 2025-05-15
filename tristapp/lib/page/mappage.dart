import 'package:flutter/material.dart';
import 'package:tristapp/widget/mappininfo.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "coucou, je serai bientôt une map!!! (enfin sauf si clélie a la flemme)",
        ),
        MapPinInfo(),
      ],
    );
  }
}
