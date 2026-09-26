import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/item/item.dart';
import '../shared/constants/space_constants.dart';
import '../shared/controllers/split_screen_controller.dart';
import '../shared/ui/extentions/monetary_extentions.dart';

class AddParticipantScreen extends StatefulWidget {
  final int? editIndex;
  final String? initialName;

  const AddParticipantScreen({super.key})
      : editIndex = null,
        initialName = null;

  const AddParticipantScreen.edit({
    super.key,
    required this.editIndex,
    required this.initialName,
  });

  @override
  State<AddParticipantScreen> createState() => _AddParticipantScreenState();
}

class _AddParticipantScreenState extends State<AddParticipantScreen> {
  late final TextEditingController _nameController;
  List<Item> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    final controller =
        Provider.of<SplitScreenController>(context, listen: false);
    if (widget.editIndex != null &&
        widget.editIndex! < controller.participants.length) {
      final participant = controller.participants[widget.editIndex!];
      _selectedItems = controller.items
          .where((item) => item.consumers.contains(participant))
          .toList();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SplitScreenController>();
    final items = controller.items;

    bool participantExists() {
      final name = _nameController.text.trim();
      final nameExists = controller.participants.asMap().entries.any(
        (entry) {
          if (widget.editIndex != null && entry.key == widget.editIndex) {
            return false;
          }
          return entry.value.name.trim().toLowerCase() == name.toLowerCase();
        },
      );

      if (nameExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Já existe um participante com esse nome!',
                style: Theme.of(context).textTheme.titleMedium),
          ),
        );
      }
      return nameExists;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          widget.editIndex != null
              ? 'Editar Participante'
              : 'Adicionar Participante',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 4,
        shadowColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpaceConstants.medium),
            TextField(
              autofocus: true,
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Nome do Participante',
                labelStyle: Theme.of(context).textTheme.titleMedium,
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: SpaceConstants.medium),
            if (items.isNotEmpty) ...[
              Text(
                'Itens consumidos',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CheckboxListTile(
                dense: true,
                title: Text(
                  'Todos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                tristate: true,
                value: _selectedItems.isEmpty
                    ? false
                    : _selectedItems.length == items.length
                        ? true
                        : null,
                onChanged: (_) {
                  setState(() {
                    final isAllSelected = _selectedItems.length == items.length;
                    if (isAllSelected) {
                      _selectedItems.clear();
                    } else {
                      _selectedItems = List.from(items);
                    }
                  });
                },
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return CheckboxListTile(
                      title: Text(item.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text('Total: ${item.price.toCurrency()}',
                          style: Theme.of(context).textTheme.titleSmall),
                      value: _selectedItems.contains(item),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selectedItems.add(item);
                          } else {
                            _selectedItems.remove(item);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ] else ...[
              const Spacer(),
            ],
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          final name = _nameController.text.trim();

          if (name.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('O participante deve ter nome!',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            );
            return;
          }

          if (participantExists()) {
            return;
          }

          if (widget.editIndex != null) {
            controller.editParticipantWithItems(
              widget.editIndex!,
              name,
              _selectedItems,
            );
          } else {
            controller.addParticipantWithItems(name, _selectedItems);
          }
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
        child: Text(
            widget.editIndex != null ? 'Salvar Alterações' : 'Adicionar',
            style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
