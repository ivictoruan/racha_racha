import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/utils/custom_utils.dart';
import '../../../shared/widgets/wrong_total_check_value_widget.dart';

// TODO: melhorar legibilidade desta classe.
class IsDrikingButtonsWidget extends StatelessWidget {
  const IsDrikingButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<CheckController>(
        builder: (_, CheckController controller, __) {
          final bool isResultButtonActivated = controller.totalDrinkPrice > 0 &&
              controller.check.totalPeopleDrinking > 0 &&
              controller.msgError == "" &&
              controller.check.isSomeoneDrinking;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: WrongTotalCheckValueWidget(),
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(15),
                shadowColor: Colors.deepPurple,
                color: Colors.white,
                child: FloatingActionButton.extended(
                  backgroundColor: isResultButtonActivated
                      ? Colors.deepPurple
                      : const Color(0xFFE0E0E0),
                  onPressed: isResultButtonActivated
                      ? () async => await _showModalIsSomeoneDrinking(
                            context,
                          )
                      : null,
                  label: const Text(
                    "Resultados",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      );

  Future<void> _showModalIsSomeoneDrinking(
    BuildContext context,
  ) async {
    CustomUtils customUtils = CustomUtils();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Todas informações estão corretas?",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceConstants.medium),
            Consumer<CheckController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText: "R\$ ${controller.totalCheckPrice}",
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Valor das bebidas: ",
                      endText:
                          "R\$ ${controller.check.totalDrinkPrice.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Gorjeta/Garçom: ",
                      endText: "${controller.waiterPercentage.toString()} %",
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Pessoas bebendo: ",
                      endText: controller.totalPeopleDrinking.toString(),
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Quantidade de pessoas: ",
                      endText: controller.totalPeople.toString(),
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    final controller = context.read<CheckController>();
                    controller.calculateCheckResult();
                    controller.isSomeoneDrinking = true;
                    customUtils.goTo("/result", context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Sim'),
                ),
                const SizedBox(width: SpaceConstants.extraSmall),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Não'),
                ),
                const SizedBox(width: SpaceConstants.extraSmall),
                TextButton.icon(
                  onPressed: () => customUtils.goTo("/totalValue", context),
                  icon: const Icon(Icons.restart_alt_rounded),
                  label: const Text("Reiniciar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;

  const ConfirmInfoWidget({
    Key? key,
    required this.startText,
    required this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle? style = Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startText, style: style),
        Text(endText, style: style),
      ],
    );
  }
}
