import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/check_controller/check_controller.dart';
import '../../../controllers/is_someone_drinking_controller.dart';
import '../../../controllers/total_people_controller.dart';
import '../../../core/utils/custom_utils.dart';
import '../../../core/widgets/confirm_info_widget.dart';
import '../../../core/widgets/wrong_total_check_value_widget.dart';

class FloatingActionButtonsWidget extends StatelessWidget {
  const FloatingActionButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();
    return Consumer<TotalPeopleController>(
      builder: (context, controller, child) {
        bool isValid = controller.state == TotalPeopleState.valid;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25),
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
                        // customUtils.goTo("/result", context);
                      }
                    }
                  : null,
              backgroundColor:
                  isValid ? Colors.deepPurple : const Color(0xFFE0E0E0),
              child: Icon(
                Icons.arrow_forward,
                size: isValid ? 28 : null,
                color: Colors.white,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.03),
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
                    const SizedBox(height: 12),
                    ConfirmInfoWidget(
                      startText: "Quantidade de pessoas: ",
                      endText: controller.totalPeople.toString(),
                    ),
                    const SizedBox(height: 12),
                    ConfirmInfoWidget(
                      startText: "Gorjeta/Garçom: ",
                      endText: "${controller.waiterPercentage.toString()} %",
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    final checkController = context.read<CheckController>();
                    final controller =
                        context.read<IsSomeoneDrinkingController>();
                    checkController.calculateCheckResult();
                    controller.isSomeoneDrinking = false;
                    customUtils.goTo("/home", context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Sim', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () {
                    customUtils.goTo("/totalValue", context);
                  },
                  icon: const Icon(Icons.restart_alt_rounded),
                  label:
                      const Text("Reiniciar", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
