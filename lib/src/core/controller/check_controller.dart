import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/check_model.dart';
import '../utils/errors/check_controller_error_mesages.dart';

import 'check_controller_interface.dart';

enum CheckState {
  totalCheckValueInvalid,
  totalCheckValueValid,
  totalPeopleValueInvalid,
  totalPeopleValueValid,
  idle,
  formValid,
  formInValid,
}

class CheckController extends ChangeNotifier
    implements CheckControllerInterface {
  final CheckModel model;

  CheckController({
    required this.model,
  });

  CheckState state = CheckState.idle;

  String msgError = CheckControllerErrorMessages.errorMsgTotalCheckPrice;

  @override
  void calculateCheckResult() {
    model.totalCheckPrice += model.totalWaiterValue; // ?
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
    notifyListeners();
    if (model.waiterPercentage == 0) {
      model.individualPriceWhoIsDrinking =
          model.individualPrice + individualTotalPriceWhoIsDrinking;
    } else {
      model.individualPriceWhoIsDrinking =
          model.individualPrice + individualTotalPriceWhoIsDrinking;
    }
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

  set totalCheckPrice(newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        var newDoubleTotalCheckPice =
            double.tryParse(newTotalCheckPrice) ?? 0.0;
        state = CheckState.totalCheckValueValid;
        model.totalCheckPrice = newDoubleTotalCheckPice;
        msgError = "";
        if (newDoubleTotalCheckPice == 0) {
          msgError = CheckControllerErrorMessages.errorMsgTotalCheckPrice;
          state = CheckState.totalCheckValueInvalid;
        }
      } else {
        model.totalCheckPrice = 0;
        state = CheckState.totalCheckValueInvalid;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('erro ao alterar o novo preço ');
    }
  }

  set totalPeople(totalPeople) {
    try {
      if (totalPeople.isNotEmpty && !totalPeople.startsWith(' ')) {
        int intTotalPeople = int.tryParse(totalPeople) ?? 1;
        state = CheckState.totalPeopleValueValid;
        model.totalPeople = intTotalPeople;
        msgError = CheckControllerErrorMessages.errorMsgTotalCheckPrice;
        if (intTotalPeople == 0) {
          state = CheckState.totalPeopleValueInvalid;
          msgError = "❗️ A quantidade de pessoas não pode ser igual a zero!";
          model.totalPeople = 1;
        }
      } else {
        state = CheckState.totalPeopleValueInvalid;
        model.totalPeople = 1;
        msgError = "";
      }
      notifyListeners();
    } catch (e) {
      debugPrint('erro ao alterar quantidade de pessoas');
    }
  }

  set waiterPercentage(newWaiterPercentage) {
    try {
      model.waiterPercentage = newWaiterPercentage.toDouble();
      double aux = model.totalCheckPrice * model.waiterPercentage;

      model.totalWaiterValue = aux / 100;

      notifyListeners();
      debugPrint(
          "%: ${model.waiterPercentage} e R\$: ${model.totalWaiterValue}");
    } catch (e) {
      debugPrint("Não foi possível alterar a porcentagem do garçom!");
    }
  }

  int get peopleDrinking {
    return model.totalPeopleDrinking;
  }

  set peopleDrinking(newValuePeopleDriking) {
    try {
      int intNewValuePeopleDriking = int.tryParse(newValuePeopleDriking) ?? 0;
      bool isTotalPeopleDrinkingSmallerThanTotalPeople =
          intNewValuePeopleDriking < model.totalPeople;
      if (isTotalPeopleDrinkingSmallerThanTotalPeople) {
        model.totalPeopleDrinking = intNewValuePeopleDriking;
        msgError = "";
      } else {
        msgError = CheckControllerErrorMessages.errorMsgPeopleDrinking;
        model.totalPeopleDrinking = 0;
      }
      if (intNewValuePeopleDriking == model.totalPeople) {
        msgError = CheckControllerErrorMessages.errorMsgPeopleDrinkingEveryone;
      }

      if (intNewValuePeopleDriking == 0) {
        msgError = CheckControllerErrorMessages.errorMsgNoPeopleDrinking;
      }

      if (newValuePeopleDriking.startsWith(' ')) {
        msgError = CheckControllerErrorMessages.errorMsgEmptyPeopleDrinking;
        model.totalPeopleDrinking = 0;
        msgError = CheckControllerErrorMessages.errorMsgEmptyField;
      }

      notifyListeners();
    } catch (e) {
      msgError = "Os campos devem ser preenchidos";
      model.totalPeopleDrinking = 0;
      notifyListeners(); // ?
    }
  }

  set isSomeoneDrinking(newIsSomeoneDrinking) {
    try {
      model.isSomeoneDrinking = newIsSomeoneDrinking;
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao setar newIsSomeoneDrinking");
    }
  }

  set totalDrinkPrice(newTotalDrinkPrice) {
    try {
      if (newTotalDrinkPrice.isNotEmpty &&
          !newTotalDrinkPrice.startsWith(' ')) {
        double doubleTotalDrinkPrice =
            double.tryParse(newTotalDrinkPrice) ?? 0.0;

        bool isTotalDrinkPriceSmallerThanTotalCheckPrice =
            doubleTotalDrinkPrice < model.totalCheckPrice;

        if (isTotalDrinkPriceSmallerThanTotalCheckPrice) {
          model.totalDrinkPrice = doubleTotalDrinkPrice;
          msgError = "";
        } else {
          model.totalDrinkPrice = 0;
          msgError = CheckControllerErrorMessages.errorMsgTotalDrinkPrice;
        }
        if (doubleTotalDrinkPrice == model.totalCheckPrice) {
          msgError = CheckControllerErrorMessages.errorMsgTotalDrinkPriceEqual;
        }
        if (doubleTotalDrinkPrice == 0) {
          msgError = CheckControllerErrorMessages.errorMsgNoDrinkPrice;
          model.totalDrinkPrice = 0;
        }
      } else {
        model.totalDrinkPrice = 0;
        msgError = CheckControllerErrorMessages.errorMsgInvalidFields;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao setar valor total de bebida!");
    }
  }

  @override
  Future<void> restartSplit() async {
    state = CheckState.idle;
    model.totalCheckPrice = 0;
    model.individualPrice = 0;
    model.waiterPercentage = 0;
    model.totalWaiterValue = 0;
    model.isSomeoneDrinking = false;
    model.totalDrinkPrice = 0;
    model.totalPeopleDrinking = 0;
    model.individualPriceWhoIsDrinking = 0;
    model.totalPeople = 1;
    msgError = "";
    await Future.delayed(const Duration(milliseconds: 10)); // sem isso dá erro
    notifyListeners();
  }
}
