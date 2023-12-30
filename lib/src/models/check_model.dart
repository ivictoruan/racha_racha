import 'dart:convert';

import 'package:flutter/material.dart';

class CheckModel extends ChangeNotifier {
  String uid;
  // normal, sem pessoas bebendo:
  double totalCheckPrice;
  // int totalPeopleNotDrinking;
  double individualPrice;
  // garçom
  double waiterPercentage;
  double totalWaiterValue;
  // para quem está bebendo:
  bool isSomeoneDrinking;
  double totalDrinkPrice;
  int totalPeopleDrinking;
  double individualPriceWhoIsDrinking;
  int totalPeople;
  CheckModel({
    this.uid ='',
    this.totalCheckPrice = 0,
    // this.totalPeopleNotDrinking = 1,
    this.individualPrice = 0,
    this.waiterPercentage = 0,
    this.totalWaiterValue = 0,
    this.isSomeoneDrinking = false,
    this.totalDrinkPrice = 0,
    this.totalPeopleDrinking = 0,
    this.individualPriceWhoIsDrinking = 0,
    this.totalPeople = 1,
  });

  

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'totalCheckPrice': totalCheckPrice,
      'individualPrice': individualPrice,
      'waiterPercentage': waiterPercentage,
      'totalWaiterValue': totalWaiterValue,
      'isSomeoneDrinking': isSomeoneDrinking,
      'totalDrinkPrice': totalDrinkPrice,
      'totalPeopleDrinking': totalPeopleDrinking,
      'individualPriceWhoIsDrinking': individualPriceWhoIsDrinking,
      'totalPeople': totalPeople,
    };
  }

  factory CheckModel.fromMap(Map<String, dynamic> map) {
    return CheckModel(
      uid: map['uid'] ?? '',
      totalCheckPrice: map['totalCheckPrice']?.toDouble() ?? 0.0,
      individualPrice: map['individualPrice']?.toDouble() ?? 0.0,
      waiterPercentage: map['waiterPercentage']?.toDouble() ?? 0.0,
      totalWaiterValue: map['totalWaiterValue']?.toDouble() ?? 0.0,
      isSomeoneDrinking: map['isSomeoneDrinking'] ?? false,
      totalDrinkPrice: map['totalDrinkPrice']?.toDouble() ?? 0.0,
      totalPeopleDrinking: map['totalPeopleDrinking']?.toInt() ?? 0,
      individualPriceWhoIsDrinking: map['individualPriceWhoIsDrinking']?.toDouble() ?? 0.0,
      totalPeople: map['totalPeople']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckModel.fromJson(String source) => CheckModel.fromMap(json.decode(source));

  CheckModel copyWith({
    String? uid,
    double? totalCheckPrice,
    double? individualPrice,
    double? waiterPercentage,
    double? totalWaiterValue,
    bool? isSomeoneDrinking,
    double? totalDrinkPrice,
    int? totalPeopleDrinking,
    double? individualPriceWhoIsDrinking,
    int? totalPeople,
  }) {
    return CheckModel(
      uid: uid ?? this.uid,
      totalCheckPrice: totalCheckPrice ?? this.totalCheckPrice,
      individualPrice: individualPrice ?? this.individualPrice,
      waiterPercentage: waiterPercentage ?? this.waiterPercentage,
      totalWaiterValue: totalWaiterValue ?? this.totalWaiterValue,
      isSomeoneDrinking: isSomeoneDrinking ?? this.isSomeoneDrinking,
      totalDrinkPrice: totalDrinkPrice ?? this.totalDrinkPrice,
      totalPeopleDrinking: totalPeopleDrinking ?? this.totalPeopleDrinking,
      individualPriceWhoIsDrinking: individualPriceWhoIsDrinking ?? this.individualPriceWhoIsDrinking,
      totalPeople: totalPeople ?? this.totalPeople,
    );
  }
}
