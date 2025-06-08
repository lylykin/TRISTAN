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

import 'package:flutter/widgets.dart';
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

// (Optionally) authenticate
Future<void> authenticateAdmin() async {
  String? adminIdSecretNullable = dotenv.env['SUPER_ID'];
  String? adminPassSecretNullable = dotenv.env['SUPER_PASS'];
  String adminIdSecret = adminIdSecretNullable!;
  String adminPassSecret =
      adminPassSecretNullable!; // might crash if missing env file
  await pb.collection('users').authWithPassword(adminIdSecret, adminPassSecret);
  // User line requiered for authentification in the users collection in pocketbase (collect the id and mdp of the env file)
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
      // MODIFY AS WISHED TO COLLECT THE DATAS
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
    await authenticateAdmin();
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
    await authenticateAdmin();
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

// Subscribe to changes only in the specified record
//pb.collection('sparkfun').subscribe('RECORD_ID', (e) {
//    print(e.action);
//    print(e.record);
//}, /* other options like: filter, expand, custom headers, etc. */);

// Unsubscribe
//pb.collection('sparkfun').unsubscribe('RECORD_ID'); // remove all 'RECORD_ID' subscriptions
//pb.collection('sparkfun').unsubscribe('*'); // remove all '*' topic subscriptions
//pb.collection('sparkfun').unsubscribe(); // remove all subscriptions in the collection
