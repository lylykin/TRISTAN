import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()

        );
  }
}

class HomePage extends StatelessWidget{


  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center (
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Sélectionner votre borne"),
            )
          ],
        ),
      )
    );
  }
}

