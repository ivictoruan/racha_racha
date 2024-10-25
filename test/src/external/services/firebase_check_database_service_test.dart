// import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:racha_racha/src/domain/check/entities/check_model.dart';
// import 'package:racha_racha/src/external/services/firebase_check_database_service.dart';

// void main() {
//   group('FirebaseCheckDatabaseService', () {
//     late FakeFirebaseFirestore firestore;
//     late FirebaseCheckDatabaseService service;

//     setUp(() {
//       firestore = FakeFirebaseFirestore();
//       service = FirebaseCheckDatabaseService(
//         firestore: firestore,
//         checksCollection: firestore.collection('checks'),
//       );
//     });

//     test('createCheck should add a check to the collection', () async {
//       // Criação de um objeto CheckModel
//       final check = CheckModel(
//         totalValue: 100,
//         individualPrice: 50,
//         waiterPercentage: 10,
//         totalWaiterValue: 10,
//         isSomeoneDrinking: true,
//         totalDrinkPrice: 20,
//         totalPeopleDrinking: 2,
//         individualPriceWhoIsDrinking: 60,
//         totalPeople: 4,
//       );

//       // Executa o método createCheck
//       await service.createCheck(check);

//       // Verifica se o check foi adicionado corretamente
//       final snapshot = await firestore.collection('checks').get();
//       expect(snapshot.docs.length, 1);

//       final addedCheck = snapshot.docs.first.data();
//       expect(addedCheck['totalValue'], check.totalValue);
//       expect(addedCheck['individualPrice'], check.individualPrice);
//       expect(addedCheck['waiterPercentage'], check.waiterPercentage);
//       expect(addedCheck['totalWaiterValue'], check.totalWaiterValue);
//       expect(addedCheck['isSomeoneDrinking'], check.isSomeoneDrinking);
//       expect(addedCheck['totalDrinkPrice'], check.totalDrinkPrice);
//       expect(addedCheck['totalPeopleDrinking'], check.totalPeopleDrinking);
//       expect(addedCheck['individualPriceWhoIsDrinking'],
//           check.individualPriceWhoIsDrinking);
//       expect(addedCheck['totalPeople'], check.totalPeople);
//     });
//   });
// }
