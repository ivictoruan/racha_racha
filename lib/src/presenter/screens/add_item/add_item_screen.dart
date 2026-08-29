import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/item/item.dart';
import '../../../domain/participant/participant.dart';
import '../../shared/controllers/split_screen_controller.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../shared/ui/text/text_styles.dart';
import '../../shared/extentions/monetary_extention.dart';

class AddItemScreen extends StatefulWidget {
  final int? index;
  final String? itemName;
  final double? itemPrice;
  final List<Participant>? selectedParticipants;

  const AddItemScreen({
    super.key,
    this.index,
    this.itemName,
    this.itemPrice,
    this.selectedParticipants,
  });

  const AddItemScreen.edit({
    super.key,
    required this.index,
    required this.itemName,
    required this.itemPrice,
    required this.selectedParticipants,
  });

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  late TextEditingController _nameController;
  late TextEditingController _totalPriceController;
  late List<Participant> _selectedParticipants;
  final _currencyFormatter = CurrencyTextInputFormatter();

  void initTextControllers() {
    _nameController = TextEditingController(text: widget.itemName);

    String initialFormattedPrice = '';
    if (widget.itemPrice != null && widget.itemPrice! > 0) {
      final cents = (widget.itemPrice! * 100).round().toString();
      initialFormattedPrice = _currencyFormatter
          .formatEditUpdate(
            TextEditingValue.empty,
            TextEditingValue(text: cents),
          )
          .text;
    }

    _totalPriceController = TextEditingController(text: initialFormattedPrice);
  }

  @override
  void initState() {
    super.initState();
    initTextControllers();
    _selectedParticipants = widget.selectedParticipants != null
        ? List.from(widget.selectedParticipants!)
        : [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final participants = context.read<SplitScreenController>().participants;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index == null ? 'Adicionar Item' : 'Editar Item',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              autofocus: widget.index == null,
              decoration: const InputDecoration(
                  labelText: 'Nome do Item',
                  labelStyle: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 22,
                      fontWeight: FontWeight.w500)),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            TextField(
              controller: _totalPriceController,
              decoration: const InputDecoration(
                labelText: 'Preço Total do Item',
                hintText: 'R\$ 0,00',
                labelStyle: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [_currencyFormatter],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: SpaceConstants.extraSmall),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Consumidores',
                style: TextStyles.mediumTextBold(
                    fontWeight: FontWeight.w500, fontSize: 22),
              ),
            ),
            if (participants.isNotEmpty) ...[
              CheckboxListTile(
                dense: true,
                title: const Text(
                  'Todos',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                ),
                tristate: true,
                value: _selectedParticipants.isEmpty
                    ? false
                    : _selectedParticipants.length == participants.length
                        ? true
                        : null,
                onChanged: (_) {
                  setState(() {
                    final isAllSelected =
                        _selectedParticipants.length == participants.length;
                    if (isAllSelected) {
                      _selectedParticipants.clear();
                    } else {
                      _selectedParticipants = List.from(participants);
                    }
                  });
                },
              ),
              const Divider(height: 1),
            ],
            Expanded(
              child: ListView.builder(
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  final participant = participants[index];
                  return CheckboxListTile(
                    title: Text(
                      participant.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    value: _selectedParticipants.contains(participant),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedParticipants.add(participant);
                        } else {
                          _selectedParticipants.remove(participant);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Validações
          if (_nameController.text.isEmpty || _nameController.text.length < 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                'O nome do item deve ter pelo menos 2 caracteres.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              )),
            );
            return;
          }
          if (_totalPriceController.text.isEmpty ||
              double.tryParse(
                      _totalPriceController.text.convertCurrencyValues()) ==
                  null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'O preço total do item deve ser um número válido.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20))),
            );
            return;
          }
          if (_selectedParticipants.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Você deve selecionar pelo menos um participante.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20))),
            );
            return;
          }

          if (widget.index == null) {
            context.read<SplitScreenController>().addItem(
                  item: Item(
                    name: _nameController.text,
                    price: double.parse(
                        _totalPriceController.text.convertCurrencyValues()),
                    consumers: List.from(_selectedParticipants),
                  ),
                );
          } else {
            context.read<SplitScreenController>().updateItem(
                  widget.index!,
                  _nameController.text,
                  double.parse(
                      _totalPriceController.text.convertCurrencyValues()),
                  List.from(_selectedParticipants),
                );
          }
          Navigator.pop(context);
        },
        child: Text(
          widget.index == null ? 'Adicionar Item' : 'Salvar',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
