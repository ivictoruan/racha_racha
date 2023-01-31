import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/custom_utils.dart';
import '../../../core/wigets/custom_text_field_widget.dart';
import 'package:racha_racha/src/core/controller/check_controller.dart';

class TotalValueField extends StatelessWidget {
  final CheckController controller;
  const TotalValueField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      hintText: 'R\$ 0.00',
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{1,9}$|(?=^.{1,9}$)^\d+\.\d{0,2}$'),
        ),
      ],
      labelText: "Valor total da conta",
      icon: Icons.price_change_outlined,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (newTotalCheckValue) {
        controller.totalCheckPrice = newTotalCheckValue;
      },
      onFieldSubmitted: (String newTotalCheckValue) {
        CustomUtils customUtils = CustomUtils();
        controller.totalCheckPrice = newTotalCheckValue;
        bool isValid = controller.totalCheckPrice > 0;
        isValid ? customUtils.goTo("/totalPeople", context) : null;
      },
    );
  }
}
