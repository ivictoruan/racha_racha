import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/routes/app_route_manager.dart';
import '../../../shared/ui/widgets/floating_action_button_widget.dart';
import '../../../shared/ui/widgets/restart_button_widget.dart';
import '../../is_someone_drinking/widgets/confirm_info_widget.dart';

class FloatingActionButtonsWidget extends StatelessWidget {
  const FloatingActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<CheckController>(
        builder: (context, controller, child) {
          bool isValid = controller.state == CheckState.totalPeopleValueValid;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: RestartButtonWidget(
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              FloatingActionButtonWidget(
                onPressed: () async {
                  if (controller.isSomeoneDrinking) {
                    Navigator.of(context)
                        .pushNamed(AppRouteManager.isSomeoneDrinking);
                  } else {
                    controller.check.totalDrinkPrice = 0;
                    await showModalCustomDialog(context);
                  }
                },
                isEnabled: isValid,
              ),
            ],
          );
        },
      );

  Future<void> showModalCustomDialog(BuildContext context) async =>
      await showModalBottomSheet(
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpaceConstants.medium),
              Consumer<CheckController>(
                builder: (context, controller, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText: "R\$ ${controller.totalValue}",
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Quantidade de pessoas: ",
                      endText: controller.totalPeople.toString(),
                    ),
                    const SizedBox(height: SpaceConstants.extraSmall),
                    ConfirmInfoWidget(
                      startText: "Gorjeta/Garçom: ",
                      endText: "${controller.waiterPercentage.toString()} %",
                    ),
                    const SizedBox(height: SpaceConstants.medium),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () => onYesPressed(context),
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
                ],
              ),
            ],
          ),
        ),
      );

  void onYesPressed(BuildContext context) {
    final controller = context.read<CheckController>();
    controller.calculateCheckResult();
    controller.isSomeoneDrinking = false;
    final Map<String, Object> argumentsToCheckDetailsScreen = {
      'isFinishing': true,
      'check': controller.check,
    };

    Navigator.of(context).pushNamed(
      AppRouteManager.checkDetails,
      arguments: argumentsToCheckDetailsScreen,
    );
  }
}
