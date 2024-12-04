import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/extentions/monetary_extention.dart';
import '../../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/routes/app_route_manager.dart';
import '../../../shared/ui/widgets/text_form_field_widget.dart';

class TotalDrinkValueFieldWidget extends StatelessWidget {
  final CheckController controller;
  const TotalDrinkValueFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormFieldWidget(
        enabled: controller.check.isSomeoneDrinking,
        hintText: "Digite o valor total das bebidas R\$",
        inputFormatters: <TextInputFormatter>[
          CurrencyTextInputFormatter(),
        ],
        labelText: "Valor das bebidas R\$",
        icon: Icons.price_change_outlined,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        onChanged: (String newTotalDrinkPrice) => controller.totalDrinkPrice =
            newTotalDrinkPrice.convertCurrencyValues(),
        onFieldSubmitted: (String newTotalDrinkPrice) {
          controller.totalDrinkPrice = newTotalDrinkPrice;

          final bool isContinueButtonActivated =
              controller.check.totalDrinkPrice > 0 &&
                  controller.check.totalPeopleDrinking > 0 &&
                  controller.msgError == "" &&
                  controller.check.isSomeoneDrinking;

          if (isContinueButtonActivated) {
            final Map<String, Object> argumentsToCheckDetailsScreen = {
              'isFinishing': true,
              'check': controller.check,
            };

            Navigator.of(context).pushNamed(
              AppRouteManager.checkDetails,
              arguments: argumentsToCheckDetailsScreen,
            );
          }
        },
      );
}
