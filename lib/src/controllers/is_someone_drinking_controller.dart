import 'package:flutter/material.dart';

import '../core/utils/errors/check_controller_error_mesages.dart';
import '../models/check_model.dart';

enum IsSomeoneDrinkingState {
  start,
  valid,
  invalid,
}

class IsSomeoneDrinkingController extends ChangeNotifier {
  final CheckModel model;
  IsSomeoneDrinkingController({
    required this.model,
  });

  IsSomeoneDrinkingState state = IsSomeoneDrinkingState.start;

  String msgError = '';

  bool get isSomeoneDrinking {
    return model.isSomeoneDrinking;
  }

  double get totalDrinkPrice {
    return model.totalDrinkPrice;
  }

  int get totalPeopleDrinking {
    return model.totalPeopleDrinking;
  }

  get totalPeople => model.totalPeople;

  get waiterPercentage => model.waiterPercentage;

  get totalCheckPrice => model.totalCheckPrice;

  set peopleDrinking(String newValuePeopleDrinking) {
    try {
      if (newValuePeopleDrinking.isNotEmpty) {
        int intNewValuePeopleDrinking = int.parse(newValuePeopleDrinking);
        bool isTotalPeopleDrinkingSmallerThanTotalPeople =
            intNewValuePeopleDrinking < model.totalPeople;
        if (isTotalPeopleDrinkingSmallerThanTotalPeople) {
          model.totalPeopleDrinking = intNewValuePeopleDrinking;
          debugPrint(
              'TOTAL PEOPLE  DRINKIG: (S) ${newValuePeopleDrinking.toString()} - ${newValuePeopleDrinking.runtimeType}');
          state = IsSomeoneDrinkingState.valid;
          msgError = CheckControllerErrorMessages.errorMsgEmpty;
        } else {
          state = IsSomeoneDrinkingState.invalid;
          msgError = CheckControllerErrorMessages.errorMsgPeopleDrinking;
          model.totalPeopleDrinking = 0;
        }
        if (intNewValuePeopleDrinking == model.totalPeople) {
          state = IsSomeoneDrinkingState.invalid;
          msgError =
              CheckControllerErrorMessages.errorMsgPeopleDrinkingEveryone;
        }

        if (intNewValuePeopleDrinking == 0) {
          state = IsSomeoneDrinkingState.invalid;
          msgError = CheckControllerErrorMessages.errorMsgEmpty;
        }
      }
      // model.totalPeopleDrinking = 0;
      // state = IsSomeoneDrinkingState.invalid;
      debugPrint('Q isso? (F): ${model.totalPeopleDrinking.toString()}');
    } catch (e) {
      model.totalPeopleDrinking = 0;
      state = IsSomeoneDrinkingState.invalid;
    }
    notifyListeners();
  }

  set isSomeoneDrinking(newIsSomeoneDrinking) {
    try {
      model.isSomeoneDrinking = newIsSomeoneDrinking;
    } catch (e) {
      debugPrint("Erro ao setar newIsSomeoneDrinking");
    }
    notifyListeners();
  }

  set totalDrinkPrice(newTotalDrinkPrice) {
    try {
      if (newTotalDrinkPrice.isNotEmpty &&
          !newTotalDrinkPrice.startsWith(' ')) {
        double doubleTotalDrinkPrice = double.parse(newTotalDrinkPrice);

        bool isTotalDrinkPriceSmallerThanTotalCheckPrice =
            doubleTotalDrinkPrice < model.totalCheckPrice;

        if (isTotalDrinkPriceSmallerThanTotalCheckPrice) {
          model.totalDrinkPrice = doubleTotalDrinkPrice;
          msgError = CheckControllerErrorMessages.errorMsgEmpty;
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
    } catch (e) {
      debugPrint("Erro ao setar valor total de bebida!");
    }
    notifyListeners();
  }
}
