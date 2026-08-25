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
                const SnackBar(
                  content: Text(
                    'Adicione pelo menos um participante para adicionar itens!',
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_shopping_cart_rounded,
                  color: Colors.deepPurple,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Adicionar Item',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
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
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Total: ${item.price.toCurrency()}',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 16),
                                color: Colors.deepPurple,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ChangeNotifierProvider.value(
                                        value: context
                                            .read<SplitScreenController>(),
                                        child: AddItemScreen.edit(
                                          index: index,
                                          itemName: item.name,
                                          itemPrice: item.price,
                                          selectedParticipants:
                                              item.consumers,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 16),
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
                                      size: 12,
                                      color: Colors.deepPurple,
                                    ),
                                    const SizedBox(width: 3),
                                    Text(
                                      consumer.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.deepPurple[800],
                                      ),
                                    ),
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
