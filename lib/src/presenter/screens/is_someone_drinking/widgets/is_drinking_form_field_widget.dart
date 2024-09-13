import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';
import '../fields/total_drink_value_field_widget.dart';
import '../fields/total_people_drinking_field_widget.dart';
import 'info_text_alert_widget.dart';

class IsDrinkingFormFieldWidget extends StatelessWidget {
  const IsDrinkingFormFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: Consumer<CheckController>(
        builder: (context, controller, child) {
          return Column(
            children: [
              TotalDrinkValueFieldWidget(controller: controller),
              SizedBox(height: size.height * 0.02),
              TotalPeopleDrinkingFieldWidget(controller: controller),
              if (controller.msgError != "") ...{
                SizedBox(height: size.height * 0.015),
                const InfoTextAlertWidget(),
              },
            ],
          );
        },
      ),
    );
  }
}
