import 'package:flutter/material.dart';

class CheckModel extends ChangeNotifier {
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

  
}
