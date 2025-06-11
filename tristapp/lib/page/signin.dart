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
  bool showPass = false;
  bool showConfirmPass = false;

  Future<void> signin() async {
    try {
      await pb.collection('users').create( // Needs to have access to create user even unauthentified !
        body: {
          "email" : idController.text, 
          "name" : nameController.text,
          "password" : passController.text,
          "passwordConfirm" : confirmPassController.text,
        }
      );
      setState(() => error = null); // Modifie l'état en avertissant le constructeur
      setState(() => isSigningInNotifier.value = false);
    } catch (e) {
      setState(() => error = "Erreur de d'inscription, les mots de passe ne correspondent pas ou ne sont pas assez longs (8 caractères min)");
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
                      controller: nameController,
                      decoration : const InputDecoration(labelText: "Entrez le nom d'utilisateur", hintText: "ex : Stéphane Delafuente", filled: true),
                      autofocus: false,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: passController,
                      decoration : InputDecoration(
                        labelText: "Entrez le mot de passe",
                        hintText: "Au moins huits caractères",
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
                    SizedBox(height: 10),
                    TextField(
                      controller: confirmPassController,
                      decoration : InputDecoration(
                        labelText: "Confirmez le mot de passe",
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => showConfirmPass = !showConfirmPass);
                          },
                          icon: Icon(
                            !showConfirmPass
                              ? Icons.visibility
                              : Icons.visibility_off
                            )
                        )
                      ),
                      autofocus: false,
                      obscureText: !showConfirmPass,
                    ),
                    if (error != null) Text(error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                    SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: () {
                      signin();
                    },
                    child: const Text("S'inscrire avec ces identifiants et se connecter")
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                    onPressed: () {
                      setState(() => isSigningInNotifier.value = false);
                    },
                    child: const Text("Retour à la connexion")
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