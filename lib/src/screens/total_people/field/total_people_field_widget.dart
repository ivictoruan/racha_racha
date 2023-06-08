import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/controller/check_controller.dart';
import '../../../core/utils/custom_utils.dart';
import '../../../core/wigets/custom_text_field_widget.dart';

class TotalPeopleFieldWidget extends StatelessWidget {
  final CheckController controller;
  const TotalPeopleFieldWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextFieldWidget(
      hintText: "Quantas pessoas?",
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{1,2}$|(?=^.{1,2}$)^\d+\$'),
        ),
      ],
      labelText: "Quantidade de pessoas",
      icon: Icons.people_outline_sharp,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      onChanged: (String newTotalPeople) {
        controller.totalPeople = newTotalPeople;
      },
      onFieldSubmitted: (String newTotalPeople) {
        CustomUtils customUtils = CustomUtils();
        controller.totalPeople = newTotalPeople;
        bool isValid = controller.totalPeople > 1;
        isValid ? customUtils.goTo("/isSomeoneDrinking", context) : null;
      },
      onClearTextPressed: () {
        controller.totalPeople = '1';
      },
    );
  }
}
