import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/check_model.dart';

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

  double get totalCheckPrice => model.totalCheckPrice;

  TotalValueState state = TotalValueState.start;

  set totalCheckPrice(newTotalCheckPrice) {
    try {
      if (newTotalCheckPrice.isNotEmpty &&
          !newTotalCheckPrice.startsWith(' ')) {
        var newDoubleTotalCheckPice = double.parse(newTotalCheckPrice);

        state = TotalValueState.valid;
        model.totalCheckPrice = newDoubleTotalCheckPice;
        log("Novo preço: $newDoubleTotalCheckPice");

        if (newDoubleTotalCheckPice == 0) {
          state = TotalValueState.invalid;
        }
      } else {
        model.totalCheckPrice = 0;
        state = TotalValueState.invalid;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Erro ao alterar o novo preço ');
    }
  }

  void resetTotalCheckPrice() {
    state = TotalValueState.start;

    notifyListeners();
  }
}
