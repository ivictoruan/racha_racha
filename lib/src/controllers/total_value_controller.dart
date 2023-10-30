import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/check_model.dart';
import '../services/splits/split_firebase_service.dart';

enum TotalValueState {
  start,
  valid,
  invalid,
}

class TotalValueController extends ChangeNotifier {
  final CheckModel model;
  late final SplitFirebaseService service;

  TotalValueController({
    required this.model,
  }) : super() {
    service = SplitFirebaseService();
    service.createSplit(model);
  }

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
        // UPDATE FIREBASE
        service.updateSplit(model.copyWith(
          totalCheckPrice: newDoubleTotalCheckPice,
        ));
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

  // void resetTotalCheckPrice() {
  //   state = TotalValueState.start;
  //   // model.totalCheckPrice = 0;
  //   service.updateSplit(model.copyWith(
  //     totalCheckPrice: 0,
  //   ));
    
  //   notifyListeners();
  // }
}
