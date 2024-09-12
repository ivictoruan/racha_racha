import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../../shared/utils/custom_utils.dart';
import '../../../shared/widgets/custom_text_field_widget.dart';
import '../../../shared/extentions/monetary_extention.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

class TotalValueField extends StatelessWidget {
  // TODO! REMOVER esta dependencia do controlador, passar o que é necessário
  final CheckControllerImpl controller;
  final bool? autofocus;
  const TotalValueField({Key? key, required this.controller, this.autofocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) => CustomTextFieldWidget(
        hintText: 'R\$ 0.00',
        inputFormatters: <TextInputFormatter>[
          CurrencyTextInputFormatter(),
        ],
        labelText: "Valor total da conta",
        icon: Icons.price_change_outlined,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (newTotalCheckValue) {
          controller.totalCheckPrice =
              newTotalCheckValue.convertCurrencyValues();
        },
        onFieldSubmitted: (String newTotalCheckValue) {
          CustomUtils customUtils = CustomUtils();
          controller.totalCheckPrice = newTotalCheckValue;
          bool isValid = controller.totalCheckPrice > 0;
          isValid ? customUtils.goTo("/totalPeople", context) : null;
        },
        autofocus: autofocus,
      );
}
