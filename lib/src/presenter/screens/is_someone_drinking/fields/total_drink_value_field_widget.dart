import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racha_racha/src/presenter/shared/extentions/monetary_extention.dart';

import '../../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../../shared/utils/custom_utils.dart';
import '../../../shared/widgets/custom_text_field_widget.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

import '../../../../domain/check/entities/check_model.dart';

class TotalDrinkValueFieldWidget extends StatelessWidget {
  final CheckControllerImpl controller;
  const TotalDrinkValueFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckModel model = controller.check;
    return CustomTextFieldWidget(
      enabled: model.isSomeoneDrinking,
      hintText: "Digite o valor total das bebidas R\$",
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r'^\d{1,9}$|(?=^.{1,9}$)^\d+\.\d{0,2}$'),
      //   ),
      // ],
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(),
      ],
      labelText: "Valor das bebidas R\$",
      icon: Icons.price_change_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      onChanged: (newTotalDrinkPrice) {
        controller.totalDrinkPrice = newTotalDrinkPrice.convertCurrencyValues();
      },
      onFieldSubmitted: (String newTotalDrinkPrice) {
        controller.totalDrinkPrice = newTotalDrinkPrice;
        CustomUtils customUtils = CustomUtils();

        bool isContinueButtonActivated = controller.check.totalDrinkPrice > 0 &&
            controller.check.totalPeopleDrinking > 0 &&
            controller.msgError == "" &&
            controller.check.isSomeoneDrinking;

        isContinueButtonActivated ? customUtils.goTo("/result", context) : null;
      },
    );
  }
}
