import 'package:flutter/material.dart';

class AucunResultatDisplay extends StatelessWidget {
  const AucunResultatDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Aucun résultat trouvé",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}