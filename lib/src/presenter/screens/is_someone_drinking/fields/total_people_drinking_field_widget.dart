import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/controllers/check_controller.dart';
import '../../../shared/ui/widgets/text_form_field_widget.dart';

class TotalPeopleDrinkingFieldWidget extends StatelessWidget {
  final CheckController controller;
  const TotalPeopleDrinkingFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormFieldWidget(
        enabled: controller.check.isSomeoneDrinking,
        autofocus: controller.check.isSomeoneDrinking,
        hintText: "Nº de pessoas bebendo",
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d{1,2}$|(?=^.{1,2}$)^\d+\$'),
          ),
        ],
        labelText: "Quantidade de pessoas bebendo",
        icon: Icons.people_outline_sharp,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: false,
        ),
        onChanged: (String newTotalPeopleDrinking) =>
            controller.peopleDrinking = newTotalPeopleDrinking,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (String newTotalPeopleDrinking) =>
            controller.peopleDrinking = newTotalPeopleDrinking,
      );
}
