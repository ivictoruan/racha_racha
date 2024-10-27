import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/check/entities/check_model.dart';
import '../../../shared/constants/space_constants.dart';

class CheckItemWidget extends StatelessWidget {
  final CheckModel check;
  final int index;

  const CheckItemWidget({
    Key? key,
    required this.check,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SpaceConstants.extraSmall,
          horizontal: SpaceConstants.medium,
        ),
        child: Card(
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SpaceConstants.medium),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(SpaceConstants.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.date_range_outlined),
                    const SizedBox(width: SpaceConstants.small),
                    Text(
                      'Divisão ${index + 1} - $dateFormatted',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: SpaceConstants.extraSmall),
                Divider(color: Colors.grey[300]),
                const SizedBox(height: SpaceConstants.extraSmall),
                _buildRow(
                  icon: Icons.attach_money,
                  label: 'Total:',
                  value: 'R\$ ${check.totalValue.toStringAsFixed(2)}',
                  context: context,
                ),
                _buildRow(
                  icon: Icons.person,
                  label: 'Pessoas:',
                  value: '${check.totalPeople}',
                  context: context,
                ),
                _buildRow(
                  icon: Icons.percent,
                  label: 'Porcentagem Garçom:',
                  value: '${check.waiterPercentage.toStringAsFixed(2)}%',
                  context: context,
                ),
                if (check.isSomeoneDrinking) ...[
                  const SizedBox(height: SpaceConstants.extraSmall),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: SpaceConstants.extraSmall),
                  _buildRow(
                    icon: Icons.local_drink,
                    label: 'Total Bebidas:',
                    value: 'R\$ ${check.totalDrinkPrice.toStringAsFixed(2)}',
                    context: context,
                  ),
                ],
              ],
            ),
          ),
        ),
      );

  String get dateFormatted {
    final dateFormatted = check.creationDate != null
        ? DateFormat('dd/MM/yyyy, HH:mm').format(check.creationDate!)
        : 'Data não disponível';
    return dateFormatted;
  }

  Widget _buildRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                ),
                const SizedBox(width: SpaceConstants.extraSmall),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Text(value),
          ],
        ),
      );
}
