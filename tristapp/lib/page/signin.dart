import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/main.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  String? error;

  Future<void> signin() async {
    try {
      await pb.collection('users').create(
        body: {
          "emailVisibility": false,
          "email" : idController.text, 
          "name" : nameController.text,
          "password" : passController.text,
          "passwordConfirm" : confirmPassController.text,
        }
      );
      setState(() => error = null); // Modifie l'état en avertissant le constructeur
      // INSERER CONNEXION DE L'USER OU DIRECTION VERS PAGE LOGIN
    } catch (e) {
      setState(() => error = "Erreur de d'inscription WIP PLACEHOLDER");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(text: TextSpan(
            text: "Inscription PocketBase",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              fontSize: 24,
            )
            )),
          SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20), 
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: idController,
                      decoration : const InputDecoration(labelText: "Entrez l'adresse mail", hintText: "example@gmail.com",  filled: true),
                      autofocus: true,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: idController,
                      decoration : const InputDecoration(labelText: "Entrez le nom d'utilisateur", hintText: "ex : Stéphane Delafuente", filled: true),
                      autofocus: false,
                    ),
                    if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    SizedBox(height: 20),
                    TextField(
                      controller: passController,
                      decoration : const InputDecoration(labelText: "Entrez le mot de passe", filled: true),
                      autofocus: true,
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: confirmPassController,
                      decoration : const InputDecoration(labelText: "Confirmez le mot de passe", filled: true),
                      autofocus: false,
                      obscureText: true,
                    ),
                    if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: () {
                      signin();
                    },
                    child: const Text("S'inscrire")
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}