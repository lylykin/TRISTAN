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
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 0;
  List<Widget> pagelist = [UserPage(), BinSelectPage(), MapPage()];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
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
                      icon: Icon(Icons.favorite),
                      label: Text("ta mère la favorite"),
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
          ),
        );
      },
    );
  }
}
