import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/check_controller.dart';
import '../../../shared/constants/space_constants.dart';
import '../fields/total_drink_value_field_widget.dart';
import '../fields/total_people_drinking_field_widget.dart';
import 'info_text_alert_widget.dart';

class IsDrinkingFormFieldWidget extends StatelessWidget {
  const IsDrinkingFormFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<CheckController>(
        builder: (context, CheckController controller, child) => Column(
          children: [
            TotalDrinkValueFieldWidget(controller: controller),
            const SizedBox(height: SpaceConstants.medium),
            TotalPeopleDrinkingFieldWidget(controller: controller),
            if (controller.msgError != "") ...{
              const SizedBox(height: SpaceConstants.small),
              const InfoTextAlertWidget(),
            },
          ],
        ),
      ),
    );
  }
}
