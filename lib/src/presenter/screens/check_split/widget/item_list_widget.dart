import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/ui/extentions/monetary_extentions.dart';
import '../../../shared/controllers/split_screen_controller.dart';
import '../../../shared/ui/widgets/popups/delete_popup_widget.dart';
import '../../add_item/add_item_screen.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final billSplitter = context.watch<SplitScreenController>();

    if (billSplitter.items.isEmpty) {
      return Material(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (billSplitter.participants.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Adicione pelo menos um participante para adicionar itens!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              );
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<SplitScreenController>(),
                  child: const AddItemScreen(),
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.deepPurple,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Adicionar Item',
                  style: Theme.of(context).textTheme.titleMedium,
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
        itemCount: billSplitter.items.length,
        separatorBuilder: (_, __) => Divider(
          color: Colors.grey[300],
          height: 12,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) {
          final item = billSplitter.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: Theme.of(context).textTheme.titleMedium),
                          Text('Total: ${item.price.toCurrency()}',
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 18),
                          color: Colors.deepPurple,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider.value(
                                  value: context.read<SplitScreenController>(),
                                  child: AddItemScreen.edit(
                                    index: index,
                                    itemName: item.name,
                                    itemPrice: item.price,
                                    selectedParticipants: item.consumers,
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
                          onPressed: () async {
                            final mustDelete = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) =>
                                  const DeletePopupWidget(
                                text: 'item',
                              ),
                            );
                            if (mustDelete ?? false) {
                              billSplitter.removeItem(index);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (item.consumers.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: item.consumers.map((consumer) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.deepPurple.withValues(
                                alpha: 0.25,
                              ),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 16,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(width: 3),
                              Text(consumer.name),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
