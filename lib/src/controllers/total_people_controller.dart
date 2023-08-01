import 'package:flutter/material.dart';

import '../core/models/check_model.dart';

enum TotalPeopleState {
  start,
  valid,
  invalid,
}

class TotalPeopleController extends ChangeNotifier {
  final CheckModel model;
  TotalPeopleController({
    required this.model,
  });

  TotalPeopleState state = TotalPeopleState.start;
  String msgError = "";
  int get totalPeople {
    return model.totalPeople;
  }

  set totalPeople(totalPeople) {
    try {
      if (totalPeople.isNotEmpty && !totalPeople.startsWith(' ')) {
        msgError = "";

        int intTotalPeople = int.parse(totalPeople);
        state = TotalPeopleState.valid;
        model.totalPeople = intTotalPeople;
        if (intTotalPeople == 0) {
          state = TotalPeopleState.invalid;
          model.totalPeople = 1;
          msgError = "Não é possível a divisão para nenhuma pessoa!";
        }
        if (intTotalPeople == 1) {
          state = TotalPeopleState.invalid;
          msgError = "Não é possível a divisão para apenas uma pessoa!";
        }
      } else {
        state = TotalPeopleState.invalid;
        model.totalPeople = 1;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao alterar quantidade de pessoas');
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

  set isSomeoneDrinking(newIsSomeoneDrinking) {
    try {
      model.isSomeoneDrinking = newIsSomeoneDrinking;
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao setar newIsSomeoneDrinking");
    }
  }

  double get waiterPercentage {
    return model.waiterPercentage;
  }

  bool get isSomeoneDrinking {
    return model.isSomeoneDrinking;
  }

  void restartTotalPeople() {
    state = TotalPeopleState.start;
    notifyListeners();
  }
}
