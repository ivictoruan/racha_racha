import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../../shared/widgets/text_form_field_widget.dart';

class TotalValueFieldWidget extends StatelessWidget {
  final void Function(String)? onChanged;

  final dynamic Function(String)? onFieldSubmitted;

  final bool? autofocus;

  const TotalValueFieldWidget({
    Key? key,
    this.autofocus,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

// TODO: transformar num método de build e deixar emTotalValueScreen
  @override
  Widget build(BuildContext context) => TextFormFieldWidget(
        hintText: 'R\$ 0,00',
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
