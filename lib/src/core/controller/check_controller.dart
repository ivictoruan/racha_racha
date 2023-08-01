import 'package:flutter/material.dart';

import '../models/check_model.dart';
import '../utils/errors/check_controller_error_mesages.dart';

import 'check_controller_interface.dart';

enum CheckState {
  totalPeopleValueValid,
  idle,
}

class CheckController extends ChangeNotifier
    implements CheckControllerInterface {
  final CheckModel model;

  CheckController({
    required this.model,
  });

  @override
  void calculateCheckResult() {
    model.totalCheckPrice += model.totalWaiterValue;
    if (model.isSomeoneDrinking) {
      calculateCheckResultWithDrinkers();
    } else {
      calculateCheckResultWithoutDrinkers();
    }
  }

  @override
  void calculateCheckResultWithoutDrinkers() {
    if (model.waiterPercentage == 0) {
      model.individualPrice = model.totalCheckPrice / model.totalPeople;
    } else {
      model.individualPrice = (model.totalCheckPrice / model.totalPeople) +
          (model.totalWaiterValue / model.totalPeople);
    }
    notifyListeners();
  }

  @override
  void calculateCheckResultWithDrinkers() {
    double individualTotalPriceWhoIsDrinking =
        model.totalDrinkPrice / model.totalPeopleDrinking;

    model.individualPrice =
        (model.totalCheckPrice - model.totalDrinkPrice) / model.totalPeople;
    if (model.waiterPercentage == 0) {
      model.individualPriceWhoIsDrinking =
          model.individualPrice + individualTotalPriceWhoIsDrinking;
    } else {
      model.individualPriceWhoIsDrinking =
          model.individualPrice + individualTotalPriceWhoIsDrinking;
    }
    notifyListeners();
  }

  
  @override
  Future<void> restartSplit() async {
    model.totalCheckPrice = 0;
    model.individualPrice = 0;
    model.waiterPercentage = 0;
    model.totalWaiterValue = 0;
    model.isSomeoneDrinking = false;
    model.totalDrinkPrice = 0;
    model.totalPeopleDrinking = 0;
    model.individualPriceWhoIsDrinking = 0;
    model.totalPeople = 1;
    CheckControllerErrorMessages.errorMsgEmpty;
    notifyListeners();
  }

  int get totalPeople {
    return model.totalPeople;
  }

  int get totalPeopleDrinking {
    return model.totalPeopleDrinking;
  }

  double get totalDrinkPrice {
    return model.totalDrinkPrice;
  }

  bool get isSomeoneDrinking {
    return model.isSomeoneDrinking;
  }

  double get waiterPercentage {
    return model.waiterPercentage;
  }

  double get totalWaiterValue {
    return model.totalWaiterValue;
  }

  double get individualPrice {
    return model.individualPrice;
  }

  double get individualPriceWhoIsDrinking {
    return model.individualPriceWhoIsDrinking;
  }

  double get totalCheckPrice => model.totalCheckPrice;

}
