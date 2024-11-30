import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../domain/check/repositories/check_repository.dart';
import '../../../domain/check/entities/check.dart';
import '../../../domain/check/usecases/create_check.dart';
import '../../../domain/check/usecases/share_check.dart';

enum CheckState {
  totalCheckValueInvalid,
  totalCheckValueValid,
  totalPeopleValueInvalid,
  totalPeopleValueValid,
  idle,
  formValid,
  formInValid,
}

// abstract class CheckController extends ChangeNotifier {
//   // Função para calcular o resultado da conta
//   Future<void> calculateCheckResult();
//   // Funções getter e setter para os dados de entrada (como totalValue, totalPeople, etc.)
//   set totalValue(double? newTotalCheckPrice);
//   set totalPeople(String totalPeople);
//   set waiterPercentage(double newWaiterPercentage);
//   set totalDrinkPrice(String newTotalDrinkPrice);
//   set peopleDrinking(String newValuePeopleDriking);
//   set isSomeoneDrinking(bool newIsSomeoneDrinking);
//   // Função para reiniciar a conta
//   Future<void> restartCheck();
//   // Função para deletar a conta do banco de dados
//   Future<void> delete(CheckModel check);
//   // Getter para mensagem de erro
//   String get msgError;
//   // Getter para o estado atual da conta
//   CheckState get state;
// }

class CheckController extends ChangeNotifier {
  final CheckRepository _repository;
  final ShareCheck _shareCheck;
  final CreateCheck _createCheck;

  CheckController({
    required CheckRepository repository,
    required ShareCheck shareCheck,
    required CreateCheck createCheck,
  })  : _repository = repository,
        _shareCheck = shareCheck,
        _createCheck = createCheck;

// deixar isso como privado?
  Check check = Check();

  CheckState state = CheckState.idle;

  String _msgError = "Digite o valor total da conta";

  String get msgError => _msgError;

  set msgError(String value) {
    _msgError = value;
    Future.delayed(
      Duration.zero,
      () => notifyListeners(),
    );
  }

  Future<void> calculateCheckResult() async {
    check.totalValue += check.totalWaiterValue;

    if (check.isSomeoneDrinking) {
      _calculateCheckResultWithDrinkers();
      await _createCheck.call(check: check);

      return;
    }

    _calculateCheckResultWithoutDrinkers();

    await _createCheck.call(check: check);
  }

  void _calculateCheckResultWithoutDrinkers() {
    if (check.waiterPercentage == 0) {
      check.individualPrice = check.totalValue / check.totalPeople;
    } else {
      check.individualPrice = (check.totalValue / check.totalPeople) +
          (check.totalWaiterValue / check.totalPeople);
    }
    notifyListeners();
  }

  // TODO: melhorar legibilidade
  void _calculateCheckResultWithDrinkers() {
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

  double get totalValue => check.totalValue;

  set totalValue(double? newTotalCheckPrice) {
    if (newTotalCheckPrice == null) return;
    try {
      if (newTotalCheckPrice == 0) {
        msgError = "Digite o valor total da conta";
        state = CheckState.totalCheckValueInvalid;
        notifyListeners();
        log('newTotalCheckPrice: $newTotalCheckPrice');

        return;
      }

      if (newTotalCheckPrice != 0) {
        state = CheckState.totalCheckValueValid;
        check.totalValue = newTotalCheckPrice;
        msgError = "";
      } else {
        check.totalValue = 0;
        state = CheckState.totalCheckValueInvalid;
      }
    } catch (e) {
      log('erro ao alterar o novo preço ');
    }
    notifyListeners();
  }

// TODO: adicionar tipo aqui
  set totalPeople(totalPeople) {
    try {
      if (totalPeople.isNotEmpty && !totalPeople.startsWith(' ')) {
        int intTotalPeople = int.parse(totalPeople);
        if (intTotalPeople <= 1) {
          return;
        }
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
    } catch (e) {
      log('erro ao alterar quantidade de pessoas');
    }
    notifyListeners();
  }

  // TODO: adicionar tipo aqui
  set waiterPercentage(newWaiterPercentage) {
    try {
      check.waiterPercentage = newWaiterPercentage.toDouble();
      double aux = check.totalValue * check.waiterPercentage;

      check.totalWaiterValue = aux / 100;

      log("%: ${check.waiterPercentage} e R\$: ${check.totalWaiterValue}");
    } catch (e) {
      log("Não foi possível alterar a porcentagem do garçom!");
    }
    notifyListeners();
  }

  String get peopleDrinking {
    return check.totalPeopleDrinking.toString();
  }

  set peopleDrinking(String newValuePeopleDriking) {
    if (newValuePeopleDriking.isEmpty) return;
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
    } catch (e) {
      msgError = "Os campos devem ser preenchidos";
      check.totalPeopleDrinking = 0;
    }
    notifyListeners();
  }

// TODO: adicionar tipo aqui
  set isSomeoneDrinking(newIsSomeoneDrinking) {
    try {
      check.isSomeoneDrinking = newIsSomeoneDrinking;
    } catch (e) {
      log("Erro ao setar newIsSomeoneDrinking");
    }
    notifyListeners();
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
    } catch (e) {
      log("Erro ao setar valor total de bebida!");
    }
    notifyListeners();
  }

  Future<bool> shareCheck(Check check) async {
    final result = await _shareCheck.call(check: check);

    return result.fold(
      (failure) {
        // TODO: tratar esta falha.
        log(failure.message);
        return false;
      },
      (sucess) {
        return sucess;
      },
    );
  }

  Future<void> restartCheck() async {
    state = CheckState.idle;
    check = Check();
    msgError = "";
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  Future<void> delete(Check check) async {
    _repository.deleteCheck(checkId: check.id!);
  }
}
