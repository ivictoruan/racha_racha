import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/check/entities/check_model.dart';

class CheckFirestoreDatabaseAdapter {
  static Map<String, dynamic> toMap(CheckModel check) => {
        'totalValue': check.totalValue,
        'individualPrice': check.individualPrice,
        'waiterPercentage': check.waiterPercentage,
        'totalWaiterValue': check.totalWaiterValue,
        'isSomeoneDrinking': check.isSomeoneDrinking,
        'totalDrinkPrice': check.totalDrinkPrice,
        'totalPeopleDrinking': check.totalPeopleDrinking,
        'individualPriceWhoIsDrinking': check.individualPriceWhoIsDrinking,
        'totalPeople': check.totalPeople,
        'creationDate': check.creationDate ?? DateTime.now(),
      };

  static CheckModel fromMap(Map<String, dynamic> map) => CheckModel(
        totalValue: map['totalValue'] ?? 0,
        individualPrice: map['individualPrice'] ?? 0,
        waiterPercentage: map['waiterPercentage'] ?? 10,
        totalWaiterValue: map['totalWaiterValue'] ?? 0,
        isSomeoneDrinking: map['isSomeoneDrinking'] ?? false,
        totalDrinkPrice: map['totalDrinkPrice'] ?? 0,
        totalPeopleDrinking: map['totalPeopleDrinking'] ?? 0,
        individualPriceWhoIsDrinking: map['individualPriceWhoIsDrinking'] ?? 0,
        totalPeople: map['totalPeople'] ?? 1,
        creationDate: (map['creationDate'] as Timestamp?)?.toDate(),
      );
}
