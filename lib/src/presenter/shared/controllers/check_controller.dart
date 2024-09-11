import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/check/entities/check_model.dart';
import 'package:flutter/foundation.dart';

enum CheckState {
  totalCheckValueInvalid,
  totalCheckValueValid,
  totalPeopleValueInvalid,
  totalPeopleValueValid,
  idle,
  formValid,
  formInValid,
}

abstract class CheckController extends ChangeNotifier {
  void calculateCheckResult();
  void calculateCheckResultWithDrinkers();
  void calculateCheckResultWithoutDrinkers();
  Future<void> restartCheck();
}

class CheckControllerImpl extends CheckController {
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

  @override
  void calculateCheckResult() {
    check.totalValue += check.totalWaiterValue;
    if (check.isSomeoneDrinking) {
      calculateCheckResultWithDrinkers();
      return;
    }

    calculateCheckResultWithoutDrinkers();
  }

  @override
  void calculateCheckResultWithoutDrinkers() {
    if (check.waiterPercentage == 0) {
      check.individualPrice = check.totalValue / check.totalPeople;
    } else {
      check.individualPrice = (check.totalValue / check.totalPeople) +
          (check.totalWaiterValue / check.totalPeople);
    }
    notifyListeners();
  }

  @override
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

  double get totalCheckPrice => check.totalValue;

  String trataValor(var valor) {
    FilteringTextInputFormatter.allow(
      RegExp(r'^\d{1,9}$|(?=^.{1,9}$)^\d+\.\d{0,2}$'),
    );
    return "";
  }

  set totalCheckPrice(newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        var newDoubleTotalCheckPice = double.parse(newTotalCheckPrice);
        state = CheckState.totalCheckValueValid;
        check.totalValue = newDoubleTotalCheckPice;
        msgError = "";
        if (newDoubleTotalCheckPice == 0) {
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

  int get peopleDrinking {
    return check.totalPeopleDrinking;
  }

  // TODO: adicionar tipo aqui
  set peopleDrinking(newValuePeopleDriking) {
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
    check.totalValue = 0;
    check.individualPrice = 0;
    check.waiterPercentage = 0;
    check.totalWaiterValue = 0;
    check.isSomeoneDrinking = false;
    check.totalDrinkPrice = 0;
    check.totalPeopleDrinking = 0;
    check.individualPriceWhoIsDrinking = 0;
    check.totalPeople = 1;
  }

  @override
  Future<void> restartCheck() async {
    state = CheckState.idle;
    resetCheck();
    msgError = "";
    await Future.delayed(Duration.zero);
    notifyListeners();
  }
}
