import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/routes/app_route_manager.dart';
import '../../../shared/widgets/restart_check_widget.dart';
import 'confirm_info_widget.dart';

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
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: RestartCheckWidget(
                  onPressed: () {
                    () async => await controller.restartCheck();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
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
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      // TODO! componentizar este widget (ver a mesma função em _showModalWhotIsNotDrinking na tela de alguém bebendo)
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceConstants.extraSmall),
            Consumer<CheckController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText: "R\$ ${controller.totalValue}",
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
                    const SizedBox(height: SpaceConstants.large),
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

                    final Map<String, Object> argumentsToHistoryScreen = {
                      'isFinishing': true,
                      'check': controller.check,
                    };

                    Navigator.of(context).pushNamed(
                      AppRouteManager.result,
                      arguments: argumentsToHistoryScreen,
                    );
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
                  onPressed: () {
                    context.read<CheckController>().restartCheck();
                    // TODO! rever essa forma de voltar para tela de valor total
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
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
