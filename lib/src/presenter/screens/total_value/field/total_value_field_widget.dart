import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../../shared/widgets/text_form_field_widget.dart';

class TotalValueFieldWidget extends StatelessWidget {
  final bool? autofocus;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final dynamic Function(String)? onFieldSubmitted;

  const TotalValueFieldWidget({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.autofocus,
  }) : super(key: key);

// TODO: transformar num método de build e deixar emTotalValueScreen1
  @override
  Widget build(BuildContext context) => TextFormFieldWidget(
        hintText: 'R\$ 0,00',
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          CurrencyTextInputFormatter(),
        ],
        labelText: "Valor total da conta",
        icon: Icons.price_change_outlined,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        autofocus: autofocus,
      );
}
