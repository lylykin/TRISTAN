import 'dart:ffi';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:tristapp/page/binselectpage.dart';
import 'package:tristapp/page/mappage.dart';
import 'package:tristapp/page/userpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: "secret_dont_look_at_me.env");
  runApp(const MainApp());
  subscribeToSparkfun();
  subscribeToObjet();
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
              image: Svg('assets/bgtrue.svg'),
              // image: SvgPicture.asset(assetName : 'bgtrue.svg'),
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
  List<dynamic> stationList = [
    (lat: 45.780722, long: 4.873583, stationName: "Tristan1"),
    (lat: 46.0, long: 5.0, stationName: "Tristan2"),
  ];
  var index = 0;
  late List<Widget> pagelist;

  @override
  void initState() {
    super.initState();
    pagelist = [
      UserPage(),
      BinSelectPage(stationList: stationList),
      DataPage(),
      MapPage(stationList: stationList),
    ];
  }

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
                    label: Text("ta mère la poubelle"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.data_usage),
                    label: Text("ta mère les datas"),
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
