import 'package:flutter/material.dart';
import '../../../../domain/check/entities/check.dart';
import '../../../shared/constants/space_constants.dart';
import 'result_info_widget.dart';

class ResultBodyWidget extends StatefulWidget {
  final Check check;

  const ResultBodyWidget({
    Key? key,
    required this.check,
  }) : super(key: key);

  @override
  State<ResultBodyWidget> createState() => _ResultBodyWidgetState();
}

class _ResultBodyWidgetState extends State<ResultBodyWidget> {
  Widget _buildSubtitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total: R\$ ${widget.check.totalValue.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Participantes:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
          ...widget.check.participants.map(
            (participant) => Text(
              '- ${participant.name}: R\$ ${participant.total.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Itens:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
          ),
          ...widget.check.items.map(
            (item) => Text(
              '- ${item.name} (R\$ ${item.price.toStringAsFixed(2)})',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    TextStyle headerStyle = Theme.of(context).textTheme.headlineSmall!.copyWith(
          color: Colors.deepPurple[600],
          fontWeight: FontWeight.w600,
        );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpaceConstants.screenBorder,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detalhes da Divisão",
                style: headerStyle,
              ),
              const SizedBox(height: SpaceConstants.medium),
              _buildInfoCard(
                context,
                icon: Icons.attach_money,
                label: "Total:",
                value: widget.check.totalValue.toStringAsFixed(2),
              ),
              // _buildInfoCard(
              //   context,
              //   icon: Icons.monetization_on,
              //   label: "Valor sem gorjeta:",
              //   value: (check.totalValue - check.totalWaiterValue)
              //       .toStringAsFixed(2),
              //   isVisible: check.waiterPercentage > 0,
              // ),
              // _buildInfoCard(
              //   context,
              //   icon: Icons.percent,
              //   label: "Gorjeta:",
              //   value:
              //       '${check.totalWaiterValue.toStringAsFixed(2)} (${check.waiterPercentage.toStringAsFixed(0)})%',
              // ),
              // _buildInfoCard(
              //   context,
              //   icon: Icons.local_drink,
              //   label: "Se bebeu, paga:",
              //   value: check.individualPriceWhoIsDrinking.toStringAsFixed(2),
              //   isVisible: check.isSomeoneDrinking,
              // ),
              // _buildInfoCard(
              //   context,
              //   icon: Icons.person,
              //   label: check.isSomeoneDrinking
              //       ? "Não bebeu, paga:"
              //       : "Valor individual:",
              //   value: check.individualPrice.toStringAsFixed(2),
              // ),
              // _buildInfoCard(
              //   context,
              //   icon: Icons.people_outline_sharp,
              //   label: "Pessoas:",
              //   isWithDollarSign: false,
              //   value: check.totalPeople.toString(),
              // ),
              _buildSubtitle(),
              const SizedBox(height: SpaceConstants.medium),
              Text(
                "Resumo Final",
                style: headerStyle.copyWith(
                  color: Colors.deepPurple[300],
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isVisible = true,
    bool isWithDollarSign = true,
  }) {
    if (!isVisible) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: SpaceConstants.small),
      child: ResultInfoWidget(
        icon: icon,
        isWithDollarSign: isWithDollarSign,
        startText: label,
        endText: value,
      ),
    );
  }
}
