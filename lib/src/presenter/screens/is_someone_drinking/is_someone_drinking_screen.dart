import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/utils/custom_utils.dart';
import '../../shared/widgets/title_text_widget.dart';
import 'widgets/is_drinking_buttons_widget.dart';
import 'widgets/is_drinking_form_field_widget.dart';

class IsSomeoneDrinkingScreen extends StatefulWidget {
  const IsSomeoneDrinkingScreen({Key? key}) : super(key: key);

  @override
  State<IsSomeoneDrinkingScreen> createState() =>
      _IsSomeoneDrinkingScreenState();
}

class _IsSomeoneDrinkingScreenState extends State<IsSomeoneDrinkingScreen> {
  late final CheckController controller;
  bool? isSomeoneJustDrinking;

  @override
  void initState() {
    super.initState();
    controller = context.read<CheckController>();
    controller.msgError = '';
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> onChangedIsSomeoneDriking({
    required bool isSomeoneDrinking,
  }) async {
    controller.isSomeoneDrinking = isSomeoneDrinking;
    controller.isSomeoneDrinking == true
        ? controller.msgError = "Preencha os campos se há alguém bebendo!"
        : {
            controller.msgError = "Preencha os campos se há alguém bebendo!",
            await _showModalWhotIsNotDrinking(context, CustomUtils())
          };
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => CustomWillPopWidget(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TitleTextWidget(
                    titleText: "Alguém está bebendo?",
                  ),
                  Switch(
                    value: controller.isSomeoneDrinking,
                    onChanged: (bool isSomeoneDrinking) async =>
                        await onChangedIsSomeoneDriking(
                            isSomeoneDrinking: isSomeoneDrinking),
                  ),
                ],
              ),
            ),
            controller.isSomeoneDrinking
                ? const IsDrinkingFormFieldWidget()
                : const SizedBox.shrink(),
          ],
        ),
        floatingActionButton: const IsDrikingButtonsWidget(),
      );

  Future _showModalWhotIsNotDrinking(
    BuildContext context,
    CustomUtils customUtils,
  ) async {
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
            const SizedBox(height: SpaceConstants.extraSmall),
            Text(
              "Se há alguém bebendo toque em \"Não\"",
              style: TextStyle(
                color: Colors.deepPurple[200],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SpaceConstants.extraSmall),
            Consumer<CheckController>(
              builder: (context, controller, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConfirmInfoWidget(
                      startText: "Total da conta: ",
                      endText: "R\$ ${controller.totalCheckPrice}",
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
                    controller.isSomeoneDrinking = true;
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Não'),
                ),
                const SizedBox(width: 8),
                // TODO: componentizar como SecondaryIconButtonWidget
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
