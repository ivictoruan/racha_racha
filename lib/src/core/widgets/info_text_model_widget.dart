import 'package:flutter/material.dart';

import '../../controllers/check_controller/check_controller.dart';


class InfoTextModelWidget extends StatelessWidget {
  final CheckController controller;
  const InfoTextModelWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${controller.model.totalCheckPrice.toString()}, ${controller.model.individualPrice.toString()}, ${controller.model.waiterPercentage.toString()}, ${controller.model.totalWaiterValue.toString()}, ${controller.model.isSomeoneDrinking.toString()}, ${controller.model.totalDrinkPrice.toString()}, ${controller.model.totalPeopleDrinking.toString()}, ${controller.model.individualPriceWhoIsDrinking.toString()}, ${controller.model.totalPeople.toString()}",
    );
  }
}
