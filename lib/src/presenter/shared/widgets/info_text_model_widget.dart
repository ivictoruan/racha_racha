import 'package:flutter/material.dart';

import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

class InfoTextModelWidget extends StatelessWidget {
  final CheckControllerImpl controller;
  const InfoTextModelWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${controller.check.totalValue.toString()}, ${controller.check.individualPrice.toString()}, ${controller.check.waiterPercentage.toString()}, ${controller.check.totalWaiterValue.toString()}, ${controller.check.isSomeoneDrinking.toString()}, ${controller.check.totalDrinkPrice.toString()}, ${controller.check.totalPeopleDrinking.toString()}, ${controller.check.individualPriceWhoIsDrinking.toString()}, ${controller.check.totalPeople.toString()}",
    );
  }
}
