import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import '../../../domain/check/entities/check_model.dart';

enum CheckState {
  totalCheckValueInvalid,
  totalCheckValueValid,
  totalPeopleValueInvalid,
  totalPeopleValueValid,
  idle,
  formValid,
  formInValid,
}

class CheckController extends ChangeNotifier {
  CheckModel check = CheckModel();

  CheckState state = CheckState.idle;
  String _msgError = "Digite o valor total da conta";

  String get msgError => _msgError;

  set msgError(String value) {
    _msgError = value;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  // @override
  void calculateCheckResult() {
    check.totalValue += check.totalWaiterValue;
    if (check.isSomeoneDrinking) {
      calculateCheckResultWithDrinkers();
      return;
    }

    calculateCheckResultWithoutDrinkers();
  }

  // @override
  void calculateCheckResultWithoutDrinkers() {
    if (check.waiterPercentage == 0) {
      check.individualPrice = check.totalValue / check.totalPeople;
    } else {
      check.individualPrice = (check.totalValue / check.totalPeople) +
          (check.totalWaiterValue / check.totalPeople);
    }
    notifyListeners();
  }

  // @override
  // TODO: melhorar legibilidade
  void calculateCheckResultWithDrinkers() {
    double individualTotalPriceWhoIsDrinking =
        check.totalDrinkPrice / check.totalPeopleDrinking;
    check.individualPrice =
        (check.totalValue - check.totalDrinkPrice) / check.totalPeople;
    if (check.waiterPercentage == 0) {
      check.individualPriceWhoIsDrinking =
          check.individualPrice + individualTotalPriceWhoIsDrinking;
    } else {
      check.individualPriceWhoIsDrinking =
          check.individualPrice + individualTotalPriceWhoIsDrinking;
    }
    notifyListeners();
  }

  int get totalPeople {
    return check.totalPeople;
  }

  int get totalPeopleDrinking {
    return check.totalPeopleDrinking;
  }

  double get totalDrinkPrice {
    return check.totalDrinkPrice;
  }

  bool get isSomeoneDrinking {
    return check.isSomeoneDrinking;
  }

  double get waiterPercentage {
    return check.waiterPercentage;
  }

  double get totalWaiterValue {
    return check.totalWaiterValue;
  }

  double get individualPrice {
    return check.individualPrice;
  }

  double get individualPriceWhoIsDrinking {
    return check.individualPriceWhoIsDrinking;
  }

  String get totalCheckPrice => check.totalValue.toStringAsFixed(2);

  double? parseCurrency(String formattedText) {
    String cleanedText = formattedText
        .replaceAll(RegExp(r'[^\d,]'), '')
        .replaceAll(',', '.')
        .trim();

    return double.tryParse(cleanedText);
  }

  set totalCheckPrice(String newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        state = CheckState.totalCheckValueValid;
        check.totalValue = parseCurrency(newTotalCheckPrice) ?? 0;
        msgError = "";
        if (check.totalValue == 0) {
          msgError = "Digite o valor total da conta";
          state = CheckState.totalCheckValueInvalid;
        }
      } else {
        check.totalValue = 0;
        state = CheckState.totalCheckValueInvalid;
      }
      notifyListeners();
    } catch (e) {
      log('erro ao alterar o novo preço ');
    }
  }

// TODO: adicionar tipo aqui
  set totalPeople(totalPeople) {
    try {
      if (totalPeople.isNotEmpty && !totalPeople.startsWith(' ')) {
        int intTotalPeople = int.parse(totalPeople);
        state = CheckState.totalPeopleValueValid;
        check.totalPeople = intTotalPeople;
        msgError =
            "Incluíndo você, digite a quantidade de pessoas dividindo a conta.";
        if (intTotalPeople == 0) {
          state = CheckState.totalPeopleValueInvalid;
          msgError = "❗️ A quantidade de pessoas não pode ser igual a zero!";
          check.totalPeople = 1;
        }
      } else {
        state = CheckState.totalPeopleValueInvalid;
        check.totalPeople = 1;
        msgError = "";
      }
      notifyListeners();
    } catch (e) {
      log('erro ao alterar quantidade de pessoas');
    }
  }

  // TODO: adicionar tipo aqui
  set waiterPercentage(newWaiterPercentage) {
    try {
      check.waiterPercentage = newWaiterPercentage.toDouble();
      double aux = check.totalValue * check.waiterPercentage;

      check.totalWaiterValue = aux / 100;

      notifyListeners();
      log("%: ${check.waiterPercentage} e R\$: ${check.totalWaiterValue}");
    } catch (e) {
      log("Não foi possível alterar a porcentagem do garçom!");
    }
  }

  String get peopleDrinking {
    return check.totalPeopleDrinking.toString();
  }

  set peopleDrinking(String newValuePeopleDriking) {
    try {
      int intNewValuePeopleDriking = int.parse(newValuePeopleDriking);
      bool isTotalPeopleDrinkingSmallerThanTotalPeople =
          intNewValuePeopleDriking < check.totalPeople;
      if (isTotalPeopleDrinkingSmallerThanTotalPeople) {
        check.totalPeopleDrinking = intNewValuePeopleDriking;
        msgError = "";
      } else {
        msgError = "Mais pessoas bebendo do que rachando a conta!";
        check.totalPeopleDrinking = 0;
      }
      if (intNewValuePeopleDriking == check.totalPeople) {
        msgError = "Se todos estão bebendo, toques em \"Não\"!";
      }

      if (intNewValuePeopleDriking == 0) {
        msgError = "Se não há ninguém bebendo, toques em \"Não\"!";
      }

      if (newValuePeopleDriking.startsWith(' ')) {
        msgError = "Incluíndo você, digite a quantidade de pessoas bebendo.";
        check.totalPeopleDrinking = 0;
        msgError = "O campo não pode ser vazio!";
      }

      notifyListeners();
    } catch (e) {
      msgError = "Os campos devem ser preenchidos";
      check.totalPeopleDrinking = 0;
      notifyListeners(); // ?
    }
  }

// TODO: adicionar tipo aqui
  set isSomeoneDrinking(newIsSomeoneDrinking) {
    try {
      check.isSomeoneDrinking = newIsSomeoneDrinking;
      notifyListeners();
    } catch (e) {
      log("Erro ao setar newIsSomeoneDrinking");
    }
  }

// TODO: adicionar tipo aqui
  set totalDrinkPrice(newTotalDrinkPrice) {
    try {
      if (newTotalDrinkPrice.isNotEmpty &&
          !newTotalDrinkPrice.startsWith(' ')) {
        double doubleTotalDrinkPrice = double.parse(newTotalDrinkPrice);

        bool isTotalDrinkPriceSmallerThanTotalCheckPrice =
            doubleTotalDrinkPrice < check.totalValue;

        if (isTotalDrinkPriceSmallerThanTotalCheckPrice) {
          check.totalDrinkPrice = doubleTotalDrinkPrice;
          msgError = "";
        } else {
          check.totalDrinkPrice = 0;
          msgError = "Valor das bebidas maior do que o valor total!";
        }
        if (doubleTotalDrinkPrice == check.totalValue) {
          msgError = "Valor das bebidas igual ao total, toque em \"Não\"";
        }
        if (doubleTotalDrinkPrice == 0) {
          msgError = "Se não há valor para bebidas toques em \"Não\"!";
          check.totalDrinkPrice = 0;
        }
      } else {
        check.totalDrinkPrice = 0;
        msgError = "Prencha os campos corretamente!";
      }
      notifyListeners();
    } catch (e) {
      log("Erro ao setar valor total de bebida!");
    }
  }

  void resetCheck() {
    check = CheckModel();
  }

  Future<void> restartCheck() async {
    state = CheckState.idle;
    resetCheck();
    msgError = "";
    await Future.delayed(Duration.zero);
    notifyListeners();
  }
}
