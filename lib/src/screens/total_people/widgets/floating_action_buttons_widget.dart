import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/core/widgets/wrong_total_check_value_widget.dart';

import '../../../core/controller/check_controller.dart';
import '../../../core/utils/custom_utils.dart';
import '../../is_someone_drinking/widgets/is_drinking_buttons_widget.dart';

class FloatingActionButtonsWidget extends StatelessWidget {
  const FloatingActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();
    return Consumer<CheckController>(
      builder: (context, controller, child) {
        bool isValid = controller.state == CheckState.totalPeopleValueValid;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: WrongTotalCheckValueWidget(),
            ),
            FloatingActionButton(
              elevation: isValid ? 5 : 0,
              onPressed: isValid
                  ? () async {
                      if (controller.isSomeoneDrinking) {
                        customUtils.goTo("/isSomeoneDrinking", context);
                      } else {
                        controller.model.totalDrinkPrice = 0;
                        await showModalCustomDialog(context, customUtils);
                      }
                    }
                  : null,
              backgroundColor:
                  isValid ? Colors.deepPurple : const Color(0xFFE0E0E0),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showModalCustomDialog(
      BuildContext context, CustomUtils customUtils) async {
    final size = MediaQuery.sizeOf(context);

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
              "Informações estão corretas?",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.02),
            Consumer<CheckController>(
              builder: (context, controller, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText:
                          "R\$ ${controller.totalCheckPrice.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Quantidade de pessoas: ",
                      endText: controller.totalPeople.toString(),
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Gorjeta/Garçom: ",
                      endText: "${controller.waiterPercentage.toString()} %",
                    ),
                    const SizedBox(height: 16),
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
                    controller.isSomeoneDrinking = false;
                    customUtils.goTo("/result", context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Sim'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    customUtils.goTo("/totalValue", context);
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
