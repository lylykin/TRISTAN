import 'package:flutter/material.dart';

class TristanLogoDisplay extends StatefulWidget {
  const TristanLogoDisplay({super.key});

  @override
  State<TristanLogoDisplay> createState() => _TristanLogoDisplayState();
}

class _TristanLogoDisplayState extends State<TristanLogoDisplay> {
  bool doalterativeDisplay = false;

  @override
  Widget build(BuildContext context) {
    int clickCounter = 0;
    String logoDisplay = 'assets/logo.png';
    String alterativeDisplay = 'assets/logo2.png';

    return Column(
      children: [
        Container(
          width: 80, 
          height: 50, 
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage((doalterativeDisplay) ? alterativeDisplay : logoDisplay)
            )
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              clickCounter += 1;
              if (doalterativeDisplay) {
                if (clickCounter > 1) {
                clickCounter = 0;
                setState(() {
                  doalterativeDisplay = !doalterativeDisplay;  
                }); 
              }
              } else {
                if (clickCounter > 9) {
                  clickCounter = 0;
                  setState(() {
                    doalterativeDisplay = !doalterativeDisplay;  
                  }); 
                }
              }
            }
          ),
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