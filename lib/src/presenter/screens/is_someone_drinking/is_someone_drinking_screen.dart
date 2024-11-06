import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/routes/app_route_manager.dart';
import '../../shared/widgets/will_pop_scope_widget.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/widgets/title_text_widget.dart';
import 'widgets/confirm_info_widget.dart';
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
  Widget build(BuildContext context) => WillPopScopeWidget(
        onYesPressed: onYesPressed,
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
                        await onChangedWhenIsSomeoneDriking(
                      isSomeoneDrinking: isSomeoneDrinking,
                    ),
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

  Future<void> onChangedWhenIsSomeoneDriking({
    required bool isSomeoneDrinking,
  }) async {
    controller.isSomeoneDrinking = isSomeoneDrinking;
    controller.isSomeoneDrinking == true
        ? controller.msgError = "Preencha os campos se há alguém bebendo!"
        : {
            controller.msgError = "Preencha os campos se há alguém bebendo!",
            await _showModalWhotIsNotDrinking(context)
          };
    setState(() {});
  }

  void onYesPressed() async {}

  Future _showModalWhotIsNotDrinking(
    BuildContext context,
  ) async =>
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        // TODO: componentizar este "Modal"
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConfirmInfoWidget(
                        startText: "Total da conta: ",
                        endText: "R\$ ${controller.totalValue}",
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
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      controller.isSomeoneDrinking = true;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Não'),
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      // TODO! rever essa forma de voltar para tela de valor total!
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
