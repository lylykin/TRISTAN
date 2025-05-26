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

import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final PocketBase pb = PocketBase('http://127.0.0.1:8090');

// (Optionally) authenticate
Future<void> authenticateAdmin() async {
  String? adminIdSecretNullable = dotenv.env['SUPER_ID'];
  String? adminPassSecretNullable = dotenv.env['SUPER_PASS'];
  String adminIdSecret = adminIdSecretNullable!;
  String adminPassSecret = adminPassSecretNullable!; // might crash if missing env file
  await pb.collection('users').authWithPassword(adminIdSecret, adminPassSecret);
  // User line requiered for authentification in the users collection in pocketbase (collect the id and mdp of the env file)
}

// Subscribe to changes in any sparkfun record
void subscribeToSparkfun() async {
  await authenticateAdmin();
  pb.collection('sparkfun').subscribe('*', (e) {
    print(e.action);
    print(e.record); // MODIFY AS WISHED TO COLLECT THE DATAS
  },
  /* other options like: filter, expand, custom headers, etc. */
  );
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