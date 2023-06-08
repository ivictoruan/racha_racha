import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/controller/check_controller.dart';
import '../../../core/utils/custom_utils.dart';
import '../../../core/wigets/wrong_total_check_value_widget.dart';

class IsDrikingButtonsWidget extends StatelessWidget {
  const IsDrikingButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<CheckController>(
        builder: (context, controller, child) {
          bool isResultButtonActivated = controller.totalDrinkPrice > 0 &&
              controller.model.totalPeopleDrinking > 0 &&
              controller.msgError == "" &&
              controller.model.isSomeoneDrinking;
          // Size size = MediaQuery.sizeOf(context);
          CustomUtils customUtils = CustomUtils();
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
                          context, customUtils)
                      : null,
                  // : () async =>
                  //     _showModalWhotIsNotDrinking(context, customUtils),
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

  // Future _showModalIsSomeoneDrinking(
  Future _showModalIsSomeoneDrinking(
      BuildContext context, CustomUtils customUtils) async {
    final size = MediaQuery.of(context).size;

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
            SizedBox(height: size.height * 0.02),
            Consumer<CheckController>(
              builder: (context, controller, child) {
                return Column(
                  children: [
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText:
                          "R\$ ${controller.totalCheckPrice.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Valor das bebidas: ",
                      endText:
                          "R\$ ${controller.model.totalDrinkPrice.toStringAsFixed(2)}",
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Gorjeta/Garçom: ",
                      endText: "${controller.waiterPercentage.toString()} %",
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Pessoas bebendo: ",
                      endText: controller.totalPeopleDrinking.toString(),
                    ),
                    const SizedBox(height: 8),
                    ConfirmInfoWidget(
                      startText: "Quantidade de pessoas: ",
                      endText: controller.totalPeople.toString(),
                    ),
                    const SizedBox(height: 8),
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

class ConfirmInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;

  const ConfirmInfoWidget(
      {Key? key, required this.startText, required this.endText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(startText, style: Theme.of(context).textTheme.bodyMedium),
        Text(endText, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
