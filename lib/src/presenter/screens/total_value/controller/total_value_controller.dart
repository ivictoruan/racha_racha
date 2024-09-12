import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check_model.dart';
import 'enum/total_value_state_enum.dart';

abstract class TotalValueController extends ChangeNotifier {
  double get totalCheckPrice;
  set totalCheckPrice(newTotalCheckPrice);
  void resetTotalCheckPrice();
}

class TotalValueControllerImpl extends TotalValueController {
  CheckModel model = CheckModel();

  @override
  double get totalCheckPrice => model.totalValue;

  TotalValueState state = TotalValueState.start;

  @override
  set totalCheckPrice(newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        var newDoubleTotalCheckPice = double.parse(newTotalCheckPrice);

        state = TotalValueState.valid;
        model.totalValue = newDoubleTotalCheckPice;
        log("Novo preço: $newDoubleTotalCheckPice");

        if (newDoubleTotalCheckPice == 0) {
          state = TotalValueState.invalid;
        }
      } else {
        model.totalValue = 0;
        state = TotalValueState.invalid;
      }
      notifyListeners();
    } catch (e) {
      log('Erro ao alterar o novo preço ');
    }
  }

  @override
  void resetTotalCheckPrice() {
    state = TotalValueState.start;
    notifyListeners();
  }
}
