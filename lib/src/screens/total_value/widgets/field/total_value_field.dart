import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racha_racha/src/core/extentions/monetary_extention.dart';

import '../../../../core/input_formatters/currency_text_input_formatter.dart';
import '../../../../core/utils/custom_utils.dart';
import '../../../../core/widgets/custom_text_field_widget.dart';

import '../../../../controllers/total_value_controller.dart';

class TotalValueField extends StatelessWidget {
  final TotalValueController controller;
  final bool? autofocus;
  const TotalValueField({Key? key, required this.controller, this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      hintText: 'R\$ 0.00',
      inputFormatters: <TextInputFormatter>[
        CurrencyTextInputFormatter(),
      ],
      labelText: "Valor total da conta",
      icon: Icons.price_change_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (newTotalCheckValue) {
        controller.totalCheckPrice = newTotalCheckValue.convertCurrencyValues();
      },
      onFieldSubmitted: (String newTotalCheckValue) {
        CustomUtils customUtils = CustomUtils();
        controller.totalCheckPrice = newTotalCheckValue.convertCurrencyValues();

        bool isValid = controller.totalCheckPrice > 0;
        isValid ? customUtils.goTo("/totalPeople", context) : null;
      },
      autofocus: autofocus,
    );
  }
}
