import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/core/utils/custom_utils.dart';

import '../../controllers/check_controller/check_controller.dart';
import '../../controllers/is_someone_drinking_controller.dart';
import '../../core/widgets/confirm_info_widget.dart';
import '../../core/widgets/custom_title_text_widget.dart';
import '../../core/widgets/custom_will_pop_scope_widget.dart';
import 'widgets/is_drinking_buttons_widget.dart';
import 'widgets/is_drinking_form_field_widget.dart';

class IsSomeoneDrinkingScreen extends StatefulWidget {
  const IsSomeoneDrinkingScreen({Key? key}) : super(key: key);

  @override
  State<IsSomeoneDrinkingScreen> createState() =>
      _IsSomeoneDrinkingScreenState();
}

class _IsSomeoneDrinkingScreenState extends State<IsSomeoneDrinkingScreen> {
  late final IsSomeoneDrinkingController controller;
  bool? isSomeoneJustDrinking;

  @override
  void initState() {
    super.initState();
    controller = context.read<IsSomeoneDrinkingController>();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return CustomWillPopWidget(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.local_bar_rounded,
                      color: Colors.deepPurple,
                      size: 32,
                    ),
                    CustomTitleTextWidget(titleText: "Alguém está bebendo?"),
                  ],
                ),
                Expanded(
                  child: Switch(
                    value: controller.isSomeoneDrinking,
                    onChanged: (bool isSomeoneDrinking) {
                      _onChangedIsSomeoneDriking(isSomeoneDrinking);
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.isSomeoneDrinking,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.01 * size.height),
              child: const IsDrinkingFormFieldWidget(),
            ),
          ),
          // TODO: Desenvolver funcionalidade para pessoas que estão apenas bebendo
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       const CustomSubtitleTextWidget(
          //         subtitle: "Alguém está apenas bebendo?",
          //       ),
          //       Switch(
          //           value: isSomeoneJustDrinking ?? false,
          //           onChanged: (bool newValue) {
          //             setState(() {
          //               isSomeoneJustDrinking = newValue;
          //             });
          //           }),
          //     ],
          //   ),
          // ),
          // isSomeoneJustDrinking ?? false
          //     ? const CustomTextFieldWidget(
          //         labelText: 'Quantas pessoas apenas bebendo?')
          //     : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: const IsDrikingButtonsWidget(),
    );
  }

  Future _onChangedIsSomeoneDriking(bool isSomeoneDrinking) async {
    controller.isSomeoneDrinking = isSomeoneDrinking;
    if (controller.isSomeoneDrinking == false) {
      bool isSomeoneRealyNotDrinking =
          await _showConfirmationPeopleNotDrinkingDialog(context);
      if (isSomeoneRealyNotDrinking) {
        setState(() {
          _showModalWhotIsNotDrinking(context, CustomUtils());
        });
        controller.isSomeoneDrinking = false;
        return;
      }
    }

    setState(() {
      controller.isSomeoneDrinking = true;
    });
  }

  Future<bool> _showConfirmationPeopleNotDrinkingDialog(
      BuildContext context) async {
    bool? confirmationResult = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                "Confirmação",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          content:
              const Text("Você tem certeza de que não há ninguém bebendo?"),
          actions: [
            TextButton(
              child: const Text(
                "Sim",
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text(
                "Não",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );

    return confirmationResult ?? false;
  }

  Future<void> _showModalWhotIsNotDrinking(
      BuildContext context, CustomUtils customUtils) async {
    final size = MediaQuery.sizeOf(context);

    showModalBottomSheet(
      context: context,
      isDismissible: false,
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
            SizedBox(height: size.height * 0.01),
            Text(
              "Se há alguém bebendo toque em \"Não\"",
              style: TextStyle(
                color: Colors.deepPurple[200],
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
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
                    final checkController = context.read<CheckController>();
                    checkController.calculateCheckResult();
                    controller.isSomeoneDrinking = false;
                    customUtils.goTo("/home", context);
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
