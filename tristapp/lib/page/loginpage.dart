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
  String? resetEmailSent;
  bool showPass = false;

  Future<void> login() async {
    try {
      await pb.collection('users').authWithPassword(idController.text, passController.text);
      setState(() => error = null); // Modifie l'état en avertissant le constructeur
      // L'utilisateur est connecté à partir d'ici
      if (pb.authStore.isValid) {
        subscribeToObjet();
        fetchItemsData();
        fetchAllItemsData();
        isLoggedInNotifier.value = true;
      }
    } catch (e) {
      setState(() => error = "Erreur de connexion : mot de passe ou identifiant incorrect");
    }
  }

  Future<void> resetPass() async {
    try {
      await pb.collection('users').requestPasswordReset(idController.text);
      setState(() => resetEmailSent = "Email envoyé à l'adresse ${idController.text}");
      setState(() => error = null); // Modifie l'état en avertissant le constructeur
    } catch (e) {
      setState(() => resetEmailSent = null);
      setState(() => error = "Erreur de réinitialisation : email vide ou non existant");
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
                      decoration : InputDecoration(
                        labelText: "Entrez le mot de passe",
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => showPass = !showPass);
                          },
                          icon: Icon(
                            !showPass
                              ? Icons.visibility
                              : Icons.visibility_off
                            )
                        )
                      ),
                      autofocus: false,
                      obscureText: !showPass,
                    ),
                    if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        resetPass();
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Reset Password",
                          style: TextStyle(
                            color: Color.fromARGB(255, 99, 99, 101),
                            decoration: TextDecoration.underline
                          )
                        )
                      )
                    ),
                    if (resetEmailSent != null) Text(resetEmailSent!, style: TextStyle(color: Color.fromARGB(255, 88, 112, 99))),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Theme.of(context).highlightColor)),
                      child: RichText(
                        text: TextSpan(
                          text: "Se connecter",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).colorScheme.primary),
                        )
                      )
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => isSigningInNotifier.value = true);
                      },
                      child: const Text("Créer un compte"),
                    ),
                    SizedBox(height: 5),  // VVVVV DEBUG MODE ONLY VVVVVV
                    ElevatedButton(
                    onPressed: () {
                      authenticateAdmin();
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