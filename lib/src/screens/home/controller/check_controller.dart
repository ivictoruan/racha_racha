// No controller: VALIDAÇÕES E E PARSING ( PARA VIEW)

// No model: consumo da regra de negócio (casos de uso)

import 'package:flutter/material.dart';

import '../../../core/models/check_model.dart';
import 'check_controller_interface.dart';
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

class CheckController extends ChangeNotifier
    implements CheckControllerInterface {
  final CheckModel model;

  CheckController({
    required this.model,
  });

  CheckState state = CheckState.idle;

  String msgError = "Digite o valor total da conta";

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

  // final CheckValidation validation;
  // final TotalValueController totalValueScreenController;
  // final TotalPeopleController totalPeopleScreenController;
  // final IsSomeoneDrikingController isSomeoneDrikingScreenController;
  // final ResultController resultScreenController;

  // bool isCheckFormValidated() {
  //   if (model.isSomeoneDrinking) {
  //     if (model.totalCheckPrice > 0 &&
  //         model.totalPeople > 0 &&
  //         model.totalPeople > model.totalPeopleDrinking &&
  //         model.totalCheckPrice > model.totalDrinkPrice) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     if (model.totalCheckPrice > 0 && model.totalPeople > 0) {
  //       return true;
  //     } else {
  //       debugPrint('Formulário Inválido!');
  //       return false;
  //     }
  //   }
  // }

  double get totalCheckPrice => model.totalCheckPrice;

  set totalCheckPrice(newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        var newDoubleTotalCheckPice = double.parse(newTotalCheckPrice);
        state = CheckState.totalCheckValueValid;
        model.totalCheckPrice = newDoubleTotalCheckPice;
        msgError = "";
        if (newDoubleTotalCheckPice == 0) {
          msgError = "Digite o valor total da conta";
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
        int intTotalPeople = int.parse(totalPeople);
        state = CheckState.totalPeopleValueValid;
        model.totalPeople = intTotalPeople;
        msgError = "";
        if (intTotalPeople == 0) {
          state = CheckState.totalPeopleValueInvalid;
          model.totalPeople = 1;
          msgError = "A quantidade de pessoas não pode ser igual a zero!";
        }
      } else {
        state = CheckState.totalPeopleValueInvalid;
        model.totalPeople = 1;
        msgError =
            "Incluíndo você, digite a quantidade de pessoas dividindo a conta.";
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
      int intNewValuePeopleDriking = int.parse(newValuePeopleDriking);
      bool isTotalPeopleDrinkingSmallerThanTotalPeople =
          intNewValuePeopleDriking < model.totalPeople;
      if (isTotalPeopleDrinkingSmallerThanTotalPeople) {
        model.totalPeopleDrinking = intNewValuePeopleDriking;
        msgError = "";
      } else {
        msgError = "Mais pessoas bebendo do que rachando a conta!";
        model.totalPeopleDrinking = 0;
      }
      if (intNewValuePeopleDriking == model.totalPeople) {
        msgError = "Se todos estão bebendo, toques em \"Não\"!";
      }

      if (intNewValuePeopleDriking == 0) {
        msgError = "Se não há ninguém bebendo, toques em \"Não\"!";
      }

      if (newValuePeopleDriking.startsWith(' ')) {
        msgError = "Incluíndo você, digite a quantidade de pessoas bebendo.";
        model.totalPeopleDrinking = 0;
        msgError = "O campo não pode ser vazio!";
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
        double doubleTotalDrinkPrice = double.parse(newTotalDrinkPrice);

        bool isTotalDrinkPriceSmallerThanTotalCheckPrice =
            doubleTotalDrinkPrice < model.totalCheckPrice;

        if (isTotalDrinkPriceSmallerThanTotalCheckPrice) {
          model.totalDrinkPrice = doubleTotalDrinkPrice;
          msgError = "";
        } else {
          model.totalDrinkPrice = 0;
          msgError = "Valor das bebidas maior do que o valor total!";
        }
        if (doubleTotalDrinkPrice == model.totalCheckPrice) {
          msgError = "Valor das bebidas igual ao total, toque em \"Não\"";
        }
        if (doubleTotalDrinkPrice == 0) {
          msgError = "Se não há valor para bebidas toques em \"Não\"!";
          model.totalDrinkPrice = 0;
        }
      } else {
        model.totalDrinkPrice = 0;
        msgError = "Prencha os campos corretamente!";
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
