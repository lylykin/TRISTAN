import 'package:flutter/material.dart';
import 'package:tristapp/data/sensordata.dart';
import 'package:tristapp/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final idController = TextEditingController();
  final passController = TextEditingController();
  String? error;

  Future<void> login() async {
    try {
      currentAuthData.value = await pb.collection('users').authWithPassword(idController.text, passController.text);
      setState(() => error = null); // Modifie l'état en avertissant le constructeur
      // L'utilisateur est connecté à partir d'ici
      subscribeToSparkfun();
      subscribeToObjet();
      fetchSparkfunData();
      isLoggedInNotifier.value = true;
    } catch (e) {
      setState(() => error = "Erreur de connexion : mot de passe ou identifiant incorrect");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(text: TextSpan(
            text: "Authentification PocketBase",
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
                      controller: passController,
                      decoration : const InputDecoration(labelText: "Entrez le mot de passe", filled: true),
                      autofocus: false,
                      obscureText: true,
                    ),
                    if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text("Se connecter")
                    ),
                    SizedBox(height: 10),  // VVVVV DEBUG MODE ONLY VVVVVV
                    ElevatedButton(
                    onPressed: () {
                      authenticateAdmin();
                      subscribeToSparkfun();
                      subscribeToObjet();
                      fetchSparkfunData();
                      isLoggedInNotifier.value = true;
                    },
                    child: const Text("Se connecter en utilisant le fichier env")
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