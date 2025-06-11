import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tristapp/main.dart';

final PocketBase pb = PocketBase('https://vps-2244fb93.vps.ovh.net'); // Interface : https://vps-2244fb93.vps.ovh.net/_/
//final ValueNotifier<Map<String, dynamic>?> sparkfunDataNotifier = ValueNotifier(null);
final ValueNotifier<Map<String, dynamic>?> itemsDataNotifier = ValueNotifier(null); // Valeurs temps réel communiquées avec l'app
//final ValueNotifier<List<Map<String, dynamic>?>> sparkfunHistoryNotifier = ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>>> itemsHistoryNotifier = ValueNotifier([]); // Valeurs contenant l'ensemble des données des tables sous forme de liste
final ValueNotifier<bool> displayInputObjectNotifier = ValueNotifier(false);
final ValueNotifier<String> inputObjectNotifier = ValueNotifier("");
final ValueNotifier<bool> subscribedNotifier = ValueNotifier(true);
final ValueNotifier<int> nObjectScannedUserNotifier = ValueNotifier(0);

Completer<String>? _currentInputCompleter; // Collecte les entrées de l'utilisateur

// (Optionally) authenticate with env file
Future<void> authenticateAdmin() async {
  String? adminIdSecretNullable = dotenv.env['SUPER_ID'];
  String? adminPassSecretNullable = dotenv.env['SUPER_PASS'];
  String adminIdSecret = adminIdSecretNullable!;
  String adminPassSecret = adminPassSecretNullable!; // might crash if missing env file
  await pb.collection('users').authWithPassword(adminIdSecret, adminPassSecret);
  // User line requiered for authentification in the users collection in pocketbase (collect the id and mdp of the env file)
  if (pb.authStore.isValid) {
    subscribeToObjet();
    fetchItemsData();
    isLoggedInNotifier.value = true;
  }
}

// Subscribe to changes in any sparkfun record
// IMPORTANT : on pocketbase server, use @request.auth.id != "" to allow avery connected users to acess the modifications
/*
void subscribeToSparkfun() async {
  try {
    print("Subscribing to sparkfun...");
    pb.collection('sparkfun').subscribe('*', (e) {
      print("Event received from sparkfun!");
      Map<String, dynamic>? record = e.toJson();
      print(record);
      sparkfunDataNotifier.value = record;

      if (record["action"] == "create") {
        print("Adding custom object name..."); // Ajout d'un nouvel objet si une nouvelle mesure est effectuée
        newObject(e.record);
      }
      ;
    });
    print("Subscription done");
  } catch (e) {
    print('Error while subscribing to PocketBase : $e');
    subscribedNotifier.value = false;
  }
}
*/

// IMPORTANT : on pocketbase server, use @request.auth.id != "" to allow avery connected users to acess the modifications
void subscribeToObjet() async {
  try {
    print("Subscribing to objet...");
    pb.collection('objet').subscribe('*', (e) async {
      print("Event received from objet : ${e.action}");
      Map<String, dynamic>? record =
          e.record!.toJson();
      print(record);
      if (e.action == "create" || e.action == "update") {
        try {
          record['expand'] = {};
          record['expand']['sparkfun_via_objet'] = []; // Définition du format pour coller au format historique
          List<dynamic> expandList = record['expand']['sparkfun_via_objet'];
          RecordModel result = await pb.collection('sparkfun').getFirstListItem( // Récupération de la première (normalement seule) mesure du capteur correspondant à l'objet 
            'objet = "${record['id']}"',
            expand: "borne"
          );
          expandList.add(result.toJson());
          
          record['recyclability'] = await isRecyclable(record['materiau']); // Ajoute la recyclabilité de l'objet récupéré

          nObjectScannedUserNotifier.value += 1; // Ajout d'un nouvel objet au score
          itemsDataNotifier.value = record;
          print("Updated realtime measurement");
        } catch (err) {
          print("Error while updating realtime measurement : $err");
        }
      }
    });
    print("Subscription done");
  } catch (e) {
    print('Error while subscribing to PocketBase : $e');
    subscribedNotifier.value = false;
  }
}

//void fetchSparkfunData() async {
//  try {
//    print("Authenticated, fetching from sparkfun...");
//    final resultList = await pb
//      .collection('sparkfun')
//      .getFullList(
//        sort: '-updated', // Liste triée par ordre de mise à jour
//      );
//    List<Map<String, dynamic>?> recordsList = [];
//    for (RecordModel record in resultList) {
//      // Convertis les élements RecordModel de la liste en dictionnaires (Map)
//      recordsList.add(record.toJson());
//    }
//    print(recordsList);
//    sparkfunHistoryNotifier.value = recordsList;
//    print("Fetch done for sparkfun");
//  } catch (e) {
//    print('Error while fetching full list from PocketBase : $e');
//  }
//}

void fetchItemsData() async {
  try {
    print("Fetching from objet...");
    String? userId = pb.authStore.record!.id; // On suppose que l'utilisateur doit être connecté sous peine d'erreur
    final resultList = await pb
      .collection('objet')
      .getFullList( // On prend les objets phase 2 (donc pas d'objet null) et on veut que les objets de l'user (avec le via on connecte les deux tables)
        filter: 'user = "$userId"',
        expand: 'sparkfun_via_objet.borne',
        sort: '-updated',
      );
    List<Map<String, dynamic>> recordsList = [];
    nObjectScannedUserNotifier.value = 0; // Remise à zéro du compteur de score (pour éviter d'incrémenter indéfiniment)
    for (RecordModel record in resultList) {
      nObjectScannedUserNotifier.value += 1; // Adaptation du score en fonction du nombre d'objets scannés
      Map<String, dynamic> recordMap = record.toJson(); // Convertis les élements RecordModel de la liste en dictionnaires (Map)
      recordMap['recyclability'] = await isRecyclable(recordMap['materiau']); // Ajoute la recyclabilité de l'objet récupéré
      recordsList.add(recordMap);
    }
    print(recordsList);
    itemsHistoryNotifier.value = recordsList;
    print("Fetch done for objet");
  } catch (e) {
    print('Error while fetching full list from PocketBase : $e');
  }
}

void newObject(lastMesure) async {
  //    Récupère les objets présents dans la bdd pour l'utilisateur et teste si le nom de l'objet en paramètre existe
  //    Se termine si l'objet existe déjà et sinon crée la ligne en récupérant le matériau et l'utilisateur en paramètre
  //    Récupère l'id de l'objet ajouté/entré
  try {
    String? userId = pb.authStore.record!.id; // On suppose que l'utilisateur doit être connecté sous peine d'erreur
    print("Authenticated, collecting user input for objet...");
    String objectNameInput = await askUserObjectName();

    if (objectNameInput.isEmpty) { // Si aucun nom entré, nom par défaut
      objectNameInput = "Objet sans nom";
    }
    print("User input for objet collected : $objectNameInput");

    // Si l'utilisateur souhaite personaliser le nom de l'objet / a répondu
    // Get list of the user's scanned items
    final resultList = await pb
        .collection('objet')
        .getFullList(
          filter:
              'user = "$userId"', // Guillemets nécessaires autour des valeurs String
        );
    List<Map<String, dynamic>?> objectsList = [];
    for (RecordModel record in resultList) {
      // Convertis les élements RecordModel de la liste en dictionnaires (Map)
      objectsList.add(record.toJson());
    }

    print("User's objets collected");
    bool contained = false; // Tiens compte si l'objet est dans la bdd
    String objetId = "";
    for (dynamic obj in objectsList) {
      if (objectNameInput == obj['nom_objet']) {
        // On suppose que les id ou nom de materiaux sont uniques pour chaque materiau et sont non vides
        objetId = obj['id'];
        contained = true;
      }
    }

    if (!contained) {
      // Si l'objet entré n'existe pas dans la bdd (not contained), l'ajouter
      Map<String, dynamic> objetInfo = {
        'user': userId,
        'nom_objet': objectNameInput,
      };
      final createdRecord = await pb
        .collection("objet")
        .create(body: objetInfo);
      objetId = createdRecord.id;
      print("Objet added in db");
    }
    // Récupère l'id de la dernière mesure insérée et lui ajoute l'objet inséré par l'utilisateur
    Map<String, dynamic> lastMesureRecord =
        lastMesure.toJson(); // On récupère l'élement sous forme de dico
    pb.collection("sparkfun").update(
      lastMesureRecord['id'],
      body: <String, dynamic>{'objet': objetId},
    );
  } catch (e) {
    print('Error while updating objet using user input : $e');
  }
}

// A TESTER POUR APPEL SANS ETRE SUR USERPAGE !!!!
Future<String> askUserObjectName() async {
  if (_currentInputCompleter != null && !_currentInputCompleter!.isCompleted) {
    // On a déjà eu un input et il n'est pas encore compélté
    _currentInputCompleter!.complete(""); // On renvoie "" pour le nom de cet objet
    displayInputObjectNotifier.value = false; // On enlève l'affichage du widget
  }

  displayInputObjectNotifier.value = true; // Affichage du widget

  final completer = Completer<String>(); // Permet de créer et compléter manuellement un Future, valeur ou erreur disponible après action de l'user
  _currentInputCompleter = completer; // Nouvelle entrée en attente

  late VoidCallback
  listener; // Déclaration d'une fonction listener initialisée ci-dessous
  listener = () {
    if (!displayInputObjectNotifier.value) {
      // Si jamais l'affichage du widget passe à false, donc que l'utilisateur a interargit avec le dialogue
      if (!completer.isCompleted) {
        // Si le nouveau completer a déjà été bien initialisé avant fermeture de l'autre ou qu'on est dans le cas où une valeur n'a pas déjà été entrée juste avant
        completer.complete(
          inputObjectNotifier.value,
        ); // Attribue la complétion du future à la valeur rentrée par l'user
      }
      displayInputObjectNotifier.removeListener(
        listener,
      ); // Fin de l'écoute de modification
      _currentInputCompleter = null; // Plus de compléteur en cours
    }
  };

  displayInputObjectNotifier.addListener(
    listener,
  ); // Début de l'écoute de l'action de l'user

  final input = await completer.future; // Définit le renvoi à l'entrée de l'user récupérée par le future complété
  return input; // Peut être "" mais pas null
}

Future<bool?> isRecyclable(String materiauId) async {
  try {
    print("Fetching from materiau...");
    final result = await pb
      .collection('materiau')
      .getOne( // On récupère le record associé à l'id entré
        materiauId,
      );
    bool recyclability = result.toJson()['recyclabilite'];
    print("Recyclability found");
    return recyclability;
  } catch (e) {
    print('Error while fetching full list from PocketBase : $e');
    return null;
  }
}