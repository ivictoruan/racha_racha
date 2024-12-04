import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/check/entities/check.dart';
import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/routes/app_route_manager.dart';
import '../../../shared/ui/widgets/restart_button_widget.dart';
import 'confirm_info_widget.dart';

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
                child: RestartButtonWidget(
                  onPressed: () {
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
                      ? () => _showModalIsSomeoneDrinking(
                            context,
                            controller.check,
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

  void _showModalIsSomeoneDrinking(
    BuildContext context,
    Check check,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => CheckConfirmationModal(check: check),
    );
  }
}

// Novo Widget para o Modal de Confirmação
class CheckConfirmationModal extends StatelessWidget {
  final Check check;

  const CheckConfirmationModal({
    Key? key,
    required this.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    endText: "R\$ ${check.totalDrinkPrice.toStringAsFixed(2)}",
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

                  final Map<String, Object> argumentsToCheckDetailsScreen = {
                    'isFinishing': true,
                    'check': controller.check,
                  };

                  Navigator.of(context).pushNamed(
                    AppRouteManager.checkDetails,
                    arguments: argumentsToCheckDetailsScreen,
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
                  // context.read<CheckController>().restartCheck();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouteManager.totalValue,
                    (route) => route.isFirst,
                  );
                },
                icon: const Icon(Icons.restart_alt_rounded),
                label: const Text("Reiniciar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
