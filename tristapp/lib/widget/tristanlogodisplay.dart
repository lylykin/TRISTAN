import 'package:flutter/material.dart';

class TristanLogoDisplay extends StatelessWidget {
  const TristanLogoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80, 
          height: 50, 
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.png')
            )
          )
        ),
        RichText(text: TextSpan(
          text: "Tristan",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            shadows: [Shadow(color: Theme.of(context).colorScheme.secondary, blurRadius: 30)],
          )
        )),
        SizedBox(height: 10)
      ],
    );
  }
}