import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../domain/check/entities/check_model.dart';

enum TotalValueState {
  start,
  valid,
  invalid,
}

class TotalValueController extends ChangeNotifier {
  final CheckModel model;

  TotalValueController({
    required this.model,
  });

  double get totalCheckPrice => model.totalValue;

  TotalValueState state = TotalValueState.start;

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

  void resetTotalCheckPrice() {
    state = TotalValueState.start;
    notifyListeners();
  }
}
