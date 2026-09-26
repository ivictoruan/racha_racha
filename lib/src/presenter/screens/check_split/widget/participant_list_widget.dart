import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/split_screen_controller.dart';
import '../../../shared/ui/widgets/popups/delete_popup_widget.dart';
import '../../../shared/ui/extentions/monetary_extentions.dart';
import '../../add_participant_screen.dart';

class ParticipantListWidget extends StatelessWidget {
  const ParticipantListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final billSplitter = context.watch<SplitScreenController>();

    if (billSplitter.participants.isEmpty) {
      return Material(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<SplitScreenController>(),
                  child: const AddParticipantScreen(),
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_add_alt,
                  color: Colors.deepPurple,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  'Adicionar Participante',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListView.separated(
        itemCount: billSplitter.participants.length,
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey[300],
          height: 12,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final participant = billSplitter.participants[index];

          final consumedItems = billSplitter.items
              .where((item) => item.consumers.contains(participant))
              .toList();

          final itemNames = consumedItems.map((item) => item.name).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(participant.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('Deve: ${participant.total.toCurrency()}',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.info_outline, size: 18),
                      color: Colors.deepPurple,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Itens consumidos',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                '${participant.name} - Itens Consumidos',
                              ),
                              content: Text(
                                itemNames.isNotEmpty
                                    ? itemNames.join(', ')
                                    : 'Este participante não consumiu itens.',
                                style: const TextStyle(fontSize: 18),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Fechar',
                                      style: TextStyle(fontSize: 18)),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      color: Colors.deepPurple,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Editar participante',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: context.read<SplitScreenController>(),
                              child: AddParticipantScreen.edit(
                                editIndex: index,
                                initialName: participant.name,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      color: Colors.deepPurple,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: 'Excluir participante',
                      onPressed: () async {
                        final mustDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) =>
                              const DeletePopupWidget(
                            text: 'Participante',
                          ),
                        );
                        if (mustDelete ?? false) {
                          billSplitter.removeParticipant(index);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
