import 'package:flutter/material.dart';

import '../models/check_model.dart';

class ResultController extends ChangeNotifier {
  final CheckModel model;
  
  ResultController({
    required this.model,
  });

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
}