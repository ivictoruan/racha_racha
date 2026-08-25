
import 'package:flutter/material.dart';

import '../../../domain/item/item.dart';
import '../../../domain/participant/participant.dart';
import '../../shared/extentions/monetary_extention.dart';
import '../../shared/input_formatters/currency_text_input_formatter.dart';


class AddItemController {
  final TextEditingController nameController;
  final TextEditingController totalPriceController;
  final CurrencyTextInputFormatter currencyFormatter;
  List<Participant> selectedParticipants;

  AddItemController({
    required String? initialName,
    required double? initialPrice,
    required List<Participant>? initialSelectedParticipants,
  })  : nameController = TextEditingController(text: initialName ?? ''),
        totalPriceController = TextEditingController(
          text: initialPrice?.toStringAsFixed(2) ?? '',
        ),
        currencyFormatter = CurrencyTextInputFormatter(),
        selectedParticipants = List.from(initialSelectedParticipants ?? []);

  void initialize() {
    totalPriceController.addListener(_formatCurrency);
  }

  void dispose() {
    nameController.dispose();
    totalPriceController.dispose();
  }

  void _formatCurrency() {
    final formattedText = currencyFormatter
        .formatEditUpdate(
          TextEditingValue.empty,
          TextEditingValue(text: totalPriceController.text),
        )
        .text;

    if (formattedText != totalPriceController.text) {
      totalPriceController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void toggleParticipantSelection(Participant participant) {
    if (selectedParticipants.contains(participant)) {
      selectedParticipants.remove(participant);
    } else {
      selectedParticipants.add(participant);
    }
  }

  bool isParticipantSelected(Participant participant) {
    return selectedParticipants.contains(participant);
  }

  String? validateInputs() {
    if (nameController.text.isEmpty || nameController.text.length < 2) {
      return 'O nome do item deve ter pelo menos 2 caracteres.';
    }
    if (totalPriceController.text.isEmpty ||
        double.tryParse(totalPriceController.text.convertCurrencyValues()) ==
            null) {
      return 'O preço total do item deve ser um número válido.';
    }
    if (selectedParticipants.isEmpty) {
      return 'Você deve selecionar pelo menos um participante.';
    }
    return null;
  }

  Item createItem() {
    return Item(
      name: nameController.text,
      price: double.parse(totalPriceController.text.convertCurrencyValues()),
      consumers: List.from(selectedParticipants),
    );
  }
}
