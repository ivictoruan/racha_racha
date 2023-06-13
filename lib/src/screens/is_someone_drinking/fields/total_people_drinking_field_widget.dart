import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/models/check_model.dart';
import '../../../core/widgets/custom_text_field_widget.dart';
import 'package:racha_racha/src/core/controller/check_controller.dart';

class TotalPeopleDrinkingFieldWidget extends StatelessWidget {
  final CheckController controller;
  const TotalPeopleDrinkingFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckModel model = controller.model;
    return CustomTextFieldWidget(
      enabled: model.isSomeoneDrinking,
      autofocus: model.isSomeoneDrinking,
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
      onChanged: (String newTotalPeopleDrinking) {
        controller.peopleDrinking = newTotalPeopleDrinking;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (String newTotalPeopleDrinking) {
        controller.peopleDrinking = newTotalPeopleDrinking;
      },
    );
  }
}
