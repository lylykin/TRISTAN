//class SensorData {
//  final List<int> sparkfunData;
//  final List<double> gpsData;
//  final bool recyclable;
//
//  SensorData(
//    this.sparkfunData;
//    this.gpsData;
//    this.recyclable;
//  );
//}
//
//List data = [
//  SensorData(
//    [11, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 14],
//    [0.1, 0.2, 0.3],
//    true,
//  ),
//]

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final PocketBase pb = PocketBase('http://vps-2244fb93.vps.ovh.net');
final ValueNotifier<Map<String, dynamic>?> sparkfunDataNotifier = ValueNotifier(
  null,
);
final ValueNotifier<Map<String, dynamic>?> itemsDataNotifier = ValueNotifier(
  null,
); // Valeurs temps réel communiquées avec l'app
final ValueNotifier<List<Map<String, dynamic>?>> sparkfunHistoryNotifier =
    ValueNotifier([]);
final ValueNotifier<List<Map<String, dynamic>?>>
itemsHistoryNotifier = ValueNotifier(
  [],
); // Valeurs contenant l'ensemble des données des tables sous forme de liste
final ValueNotifier<bool> displayInputObjectNotifier = ValueNotifier(false);
final ValueNotifier<String> inputObjectNotifier = ValueNotifier("");

Completer<String>?
_currentInputCompleter; // Collecte les entrées de l'utilisateur

// (Optionally) authenticate
Future<RecordAuth> authenticateAdmin() async {
  String? adminIdSecretNullable = dotenv.env['SUPER_ID'];
  String? adminPassSecretNullable = dotenv.env['SUPER_PASS'];
  String adminIdSecret = adminIdSecretNullable!;
  String adminPassSecret =
      adminPassSecretNullable!; // might crash if missing env file
  final authData = await pb
      .collection('users')
      .authWithPassword(adminIdSecret, adminPassSecret);
  // User line requiered for authentification in the users collection in pocketbase (collect the id and mdp of the env file)
  return authData;
}

// Subscribe to changes in any sparkfun record
// IMPORTANT : on pocketbase server, use @request.auth.id != "" to allow avery connected users to acess the modifications
void subscribeToSparkfun() async {
  try {
    await authenticateAdmin();
    print("Authenticated, subscribing to sparkfun...");
    pb.collection('sparkfun').subscribe('*', (e) {
      print("Event received from sparkfun!");
      Map<String, dynamic>? record = e.toJson();
      print(record);
      sparkfunDataNotifier.value = record;

      if (record["action"] == "create") {
        print(
          "Adding custom object name...",
        ); // Ajout d'un nouvel objet si une nouvelle mesure est effectuée
        newObject(e.record);
      }
      ;
    });
    print("Subscription done");
  } catch (e) {
    print('Error while subscribing to PocketBase : $e');
  }
}

// IMPORTANT : on pocketbase server, use @request.auth.id != "" to allow avery connected users to acess the modifications
void subscribeToObjet() async {
  try {
    await authenticateAdmin();
    print("Authenticated, subscribing to objet...");
    pb.collection('objet').subscribe('*', (e) {
      print("Event received from objet!");
      Map<String, dynamic>? record =
          e.toJson(); // TODO Si action est create, ajouter une ligne à l'affichage des objets scannés
      print(record);
      itemsDataNotifier.value = record;
      // MODIFY AS WISHED TO COLLECT THE DATAS
    });
    print("Subscription done");
  } catch (e) {
    print('Error while subscribing to PocketBase : $e');
  }
}

void fetchSparkfunData() async {
  try {
    //await authenticateAdmin();
    print("Authenticated, fetching from sparkfun...");
    final resultList = await pb
        .collection('sparkfun')
        .getFullList(
          sort: '-updated', // Liste triée par ordre de mise à jour
        );
    List<Map<String, dynamic>?> recordsList = [];
    for (RecordModel record in resultList) {
      // Convertis les élements RecordModel de la liste en dictionnaires (Map)
      recordsList.add(record.toJson());
    }
    print(recordsList);
    sparkfunHistoryNotifier.value = recordsList;
    print("Fetch done for sparkfun");
  } catch (e) {
    print('Error while fetching full list from PocketBase : $e');
  }
}

void fetchItemsData() async {
  try {
    //await authenticateAdmin();
    print("Authenticated, fetching from objet...");
    final resultList = await pb
        .collection('objet')
        .getFullList(
          // Récupère la liste complète
          sort: '-updated',
        );
    List<Map<String, dynamic>?> recordsList = [];
    for (RecordModel record in resultList) {
      // Convertis les élements RecordModel de la liste en dictionnaires (Map)
      recordsList.add(record.toJson());
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
    RecordAuth authData = await authenticateAdmin();
    String? userId = authData.record.id;
    //await authenticateAdmin();
    print("Authenticated, collecting user input for objet...");
    String objectNameInput = await askUserObjectName();
    print("User input for objet collected : $objectNameInput");

    if (objectNameInput.isNotEmpty) {
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
        print(objetInfo);
        objetId = createdRecord.id;
        print("Objet added in db");
      }

      // Récupère l'id de la dernière mesure insérée et lui ajoute l'objet inséré par l'utilisateur
      Map<String, dynamic> lastMesureRecord =
          lastMesure.toJson(); // On récupère l'élement sous forme de dico
      pb
          .collection("sparkfun")
          .update(
            lastMesureRecord['id'],
            body: <String, dynamic>{'objet': objetId},
          );
    }
  } catch (e) {
    print('Error while updating objet using user input : $e');
  }
}

// A TESTER POUR APPEL SANS ETRE SUR USERPAGE !!!!
Future<String> askUserObjectName() async {
  if (_currentInputCompleter != null && !_currentInputCompleter!.isCompleted) {
    // On a déjà eu un input et il n'est pas encore compélté
    _currentInputCompleter!.complete(
      "",
    ); // On renvoie "" pour le nom de cet objet
    displayInputObjectNotifier.value = false; // On enlève l'affichage du widget
  }

  displayInputObjectNotifier.value = true; // Affichage du widget

  final completer =
      Completer<
        String
      >(); // Permet de créer et compléter manuellement un Future, valeur ou erreur disponible après action de l'user
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

  final input =
      await completer
          .future; // Définit le renvoi à l'entrée de l'user récupérée par le future complété
  return input; // Peut être "" mais pas null
}
