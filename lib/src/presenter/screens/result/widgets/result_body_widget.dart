import 'package:flutter/material.dart';
import '../../../../domain/check/entities/check.dart';
import '../../../shared/constants/space_constants.dart';
import 'result_info_widget.dart';

class ResultBodyWidget extends StatelessWidget {
  final Check check;

  const ResultBodyWidget({
    Key? key,
    required this.check,
  }) : super(key: key);

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
                value: check.totalValue.toStringAsFixed(2),
              ),
              _buildInfoCard(
                context,
                icon: Icons.monetization_on,
                label: "Valor sem gorjeta:",
                value: (check.totalValue - check.totalWaiterValue)
                    .toStringAsFixed(2),
                isVisible: check.waiterPercentage > 0,
              ),
              _buildInfoCard(
                context,
                icon: Icons.percent,
                label: "Gorjeta:",
                value:
                    '${check.totalWaiterValue.toStringAsFixed(2)} (${check.waiterPercentage.toStringAsFixed(0)})%',
              ),
              _buildInfoCard(
                context,
                icon: Icons.local_drink,
                label: "Se bebeu, paga:",
                value: check.individualPriceWhoIsDrinking.toStringAsFixed(2),
                isVisible: check.isSomeoneDrinking,
              ),
              _buildInfoCard(
                context,
                icon: Icons.person,
                label: check.isSomeoneDrinking
                    ? "Não bebeu, paga:"
                    : "Valor individual:",
                value: check.individualPrice.toStringAsFixed(2),
              ),
              _buildInfoCard(
                context,
                icon: Icons.people_outline_sharp,
                label: "Pessoas:",
                isWithDollarSign: false,
                value: check.totalPeople.toString(),
              ),
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
