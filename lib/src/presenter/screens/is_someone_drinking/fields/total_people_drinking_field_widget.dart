import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/widgets/custom_text_field_widget.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';

import '../../../../domain/check/entities/check_model.dart';

class TotalPeopleDrinkingFieldWidget extends StatelessWidget {
  final CheckControllerImpl controller;
  const TotalPeopleDrinkingFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckModel model = controller.check;
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
