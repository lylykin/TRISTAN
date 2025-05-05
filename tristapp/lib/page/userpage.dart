import 'package:flutter/material.dart';

class UserPage extends StatelessWidget{

  const UserPage({super.key});

  @override
  Widget build (BuildContext context){
    return Column(
      children: [
        Text("Mon compte"),
        Text("identifiant : "),
        Text("Score"),
        ] 
      ,);
    }
}
