import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/controllers/check_controller.dart';
import '../../../shared/utils/custom_utils.dart';
import '../../../shared/widgets/text_form_field_widget.dart';

class TotalPeopleFieldWidget extends StatelessWidget {
  final CheckController controller;
  const TotalPeopleFieldWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      hintText: "Quantas pessoas?",
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{1,2}$|(?=^.{1,2}$)^\d+\$'),
        ),
      ],
      labelText: "Quantidade de pessoas",
      icon: Icons.people_outline_sharp,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),

      // TODO: inverter dependência do onChanged
      onChanged: (String newTotalPeople) {
        controller.totalPeople = newTotalPeople;
      },
      // TODO: inverter dependência do onFieldSubmitted

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
