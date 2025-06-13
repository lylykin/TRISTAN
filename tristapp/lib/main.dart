import 'package:flutter/material.dart';
import 'package:tristapp/page/binselectpage.dart';
import 'package:tristapp/page/loginpage.dart';
import 'package:tristapp/page/mappage.dart';
import 'package:tristapp/page/signin.dart';
import 'package:tristapp/page/userpage.dart';
import 'package:tristapp/page/settingpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/page/datapage.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:tristapp/widget/tristanlogodisplay.dart';
import 'package:tristapp/widget/notificationbubble.dart';

ValueNotifier<bool> isLoggedInNotifier = ValueNotifier(pb.authStore.isValid); // Pocketbase informe si l'utilisateur est connecté (false/true)
ValueNotifier<bool> isSigningInNotifier = ValueNotifier(false); // Rend compte de si l'utilisateur se connecte ou s'inscrit

// build app exe using : flutter build windows
// file will be located from root in \build\windows\runner\Release\
// Release file should be the one shared to share app
Future<void> main() async {
  await dotenv.load(fileName: "secret_dont_look_at_me.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: isLoggedInNotifier,
      builder: (context, isLoggedIn, child) {
        return ValueListenableBuilder(
          valueListenable: isSigningInNotifier,
          builder: (context, isSigningIn, child) {
            return MaterialApp(
              title: "TRISTAN",
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
                brightness: Brightness.light, // erreur si on met dark
              ),
              home: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Svg('assets/bgtrue.svg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: isLoggedIn
                    ? HomePage()
                    : isSigningIn
                      ? SigninPage()
                      : LoginPage(),
                ),
              )
            );
          }
        );
      }
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
    (lat: 45.780722, long: 4.873583, stationId: "tristan1", stationName: "INSA Lyon"),
    (lat: 46.0, long: 5.0, stationId: "tristan2", stationName: "Borne 2"),
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
      SettingPage(),
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
                leading: TristanLogoDisplay(),
                destinations: [
                  NavigationRailDestination(
                    icon: Stack( // Permet l'affichage conditionnel d'une bulle de notification
                      children: <Widget>[
                        Icon(Icons.home),
                        ValueListenableBuilder<bool>(
                          valueListenable: displayInputObjectNotifier,
                          builder: (context, displayInputObjectNotifier, child) {
                            return NotificationBubble(display: displayInputObjectNotifier);
                          },
                        ),
                      ],
                    ),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.delete),
                    label: Text("Bornes"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.data_usage),
                    label: Text("Données"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.map),
                    label: Text("Carte"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    label: Text("Paramètres"),
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
