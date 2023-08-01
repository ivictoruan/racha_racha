import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racha_racha/src/core/extentions/monetary_extention.dart';

import '../../../controllers/is_someone_drinking_controller.dart';
import '../../../core/input_formatters/currency_text_input_formatter.dart';
import '../../../core/models/check_model.dart';
import '../../../core/utils/custom_utils.dart';
import '../../../core/widgets/custom_text_field_widget.dart';

class TotalDrinkValueFieldWidget extends StatelessWidget {
  final IsSomeoneDrinkingController controller;
  const TotalDrinkValueFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckModel model = controller.model;
    return CustomTextFieldWidget(
      enabled: model.isSomeoneDrinking,
      hintText: "Digite o valor total das bebidas R\$",
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(),
      ],
      labelText: "Valor das bebidas R\$",
      icon: Icons.price_change_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      onChanged: (String newTotalDrinkPrice) {
        controller.totalDrinkPrice = newTotalDrinkPrice.convertCurrencyValues();
      },
      onFieldSubmitted: (String newTotalDrinkPrice) {
        controller.totalDrinkPrice = newTotalDrinkPrice.convertCurrencyValues();
        CustomUtils customUtils = CustomUtils();

        bool isContinueButtonActivated = controller.model.totalDrinkPrice > 0 &&
            controller.model.totalPeopleDrinking > 0 &&
            // controller.msgError == "" &&
            controller.model.isSomeoneDrinking;

        isContinueButtonActivated ? customUtils.goTo("/result", context) : null;
      },
    );
  }
}
