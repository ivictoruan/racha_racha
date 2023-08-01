import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../controllers/total_people_controller.dart';
import '../../../core/widgets/custom_text_field_widget.dart';

class TotalPeopleFieldWidget extends StatelessWidget {
  final TotalPeopleController controller;
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
    );
  }
}
