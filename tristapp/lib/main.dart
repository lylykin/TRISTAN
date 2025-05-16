import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tristapp/page/binselectpage.dart';
import 'package:tristapp/page/mappage.dart';
import 'package:tristapp/page/userpage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TRISTAN",
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/2fix_green_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: HomePage(),
        ),
      ),

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        brightness: Brightness.light, // erreur si on met dark
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 0;
  List<Widget> pagelist = [
    UserPage(),
    BinSelectPage(),
    MapPage(lat: 0.3, long: 0.3),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            SafeArea(
              child: NavigationRail(
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text("ta mère la homepage"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.delete),
                    label: Text("ta mère le setting"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.map),
                    label: Text("ta mère la map"),
                  ),
                ],
                selectedIndex: index,
                onDestinationSelected: (value) {
                  setState(() {
                    index = value;
                  });
                },
              ),
            ),
            Expanded(child: Container(child: pagelist[index])),
          ],
        );
      },
    );
  }
}
