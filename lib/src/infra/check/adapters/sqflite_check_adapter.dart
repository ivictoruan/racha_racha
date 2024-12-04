import '../../../domain/check/entities/check.dart';

class SqfliteCheckAdapter {
  static Map<String, dynamic> toMap(Check check) {
    return {
      'id': check.id,
      'creationDate': check.creationDate?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      'totalValue': check.totalValue,
      'individualPrice': check.individualPrice,
      'waiterPercentage': check.waiterPercentage,
      'totalWaiterValue': check.totalWaiterValue,
      'isSomeoneDrinking': check.isSomeoneDrinking ? 1 : 0,
      'totalDrinkPrice': check.totalDrinkPrice,
      'totalPeopleDrinking': check.totalPeopleDrinking,
      'individualPriceWhoIsDrinking': check.individualPriceWhoIsDrinking,
      'totalPeople': check.totalPeople,
    };
  }

  static Check fromMap(Map<String, dynamic> map) {
    return Check(
      id: map['id'] as String?,
      creationDate: map['creationDate'] != null
          ? DateTime.parse(map['creationDate'])
          : null,
      totalValue: map['totalValue'] as double,
      individualPrice: map['individualPrice'] as double,
      waiterPercentage: map['waiterPercentage'] as double,
      totalWaiterValue: map['totalWaiterValue'] as double,
      isSomeoneDrinking: (map['isSomeoneDrinking'] as int) == 1,
      totalDrinkPrice: map['totalDrinkPrice'] as double,
      totalPeopleDrinking: map['totalPeopleDrinking'] as int,
      individualPriceWhoIsDrinking:
          map['individualPriceWhoIsDrinking'] as double,
      totalPeople: map['totalPeople'] as int,
    );
  }
}
