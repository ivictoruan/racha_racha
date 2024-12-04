import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/space_constants.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/ui/widgets/subtitle_text_widget.dart';
import '../../shared/ui/widgets/will_pop_scope_widget.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/ui/widgets/text_form_field_widget.dart';
import '../../shared/ui/widgets/title_text_widget.dart';
import '../../shared/ui/widgets/slider_widget.dart';
import 'widgets/floating_action_buttons_widget.dart';

class TotalPeopleScreen extends StatefulWidget {
  const TotalPeopleScreen({Key? key}) : super(key: key);

  @override
  State<TotalPeopleScreen> createState() => _TotalPeopleScreenState();
}

class _TotalPeopleScreenState extends State<TotalPeopleScreen> {
  late final CheckController controller;
  bool serviceTax = false;

  @override
  void initState() {
    super.initState();
    controller = context.read<CheckController>();
    controller.msgError =
        "Incluíndo você, digite a quantidade de pessoas dividindo a conta.";
  }

  Future<void> onYesPressed() async {}

  @override
  Widget build(BuildContext context) => WillPopScopeWidget(
        onYesPressed: () async => await onYesPressed(),
        body: Column(
          children: [
            const TitleTextWidget(
              titleText: "Digite a quantidade de pessoas dividindo a conta",
            ),
            const SizedBox(height: SpaceConstants.medium),
            buildTextFormWidget(),
            const SizedBox(height: SpaceConstants.small),
            const SubtitleTextWidget(
              subtitle:
                  "Incluíndo você, digite a quantidade de pessoas dividindo a conta.",
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SubtitleTextWidget(
                  subtitle: "Vai pagar taxa de Serviço/Garçom?",
                ),
              ],
            ),
            ListenableBuilder(
              listenable: controller,
              builder: (_, __) => SliderWidget(
                value: controller.check.waiterPercentage,
                onChanged: (double newWaiterPercentage) {
                  controller.waiterPercentage = newWaiterPercentage;
                },
                label: controller.waiterPercentage.toStringAsFixed(0),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpaceConstants.extraSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SubtitleTextWidget(
                    subtitle: "Alguém está bebendo?",
                  ),
                  ListenableBuilder(
                    listenable: controller,
                    builder: (_, __) => Switch(
                      value: controller.isSomeoneDrinking,
                      onChanged: (bool isSomeoneDrinking) {
                        controller.isSomeoneDrinking = isSomeoneDrinking;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: const FloatingActionButtonsWidget(),
      );

  Widget buildTextFormWidget() {
    final String initialText =
        (controller.totalPeople == 1 ? '' : controller.totalPeople).toString();

    return TextFormFieldWidget(
      hintText: "Quantas pessoas?",
      controller: TextEditingController.fromValue(
        TextEditingValue(text: initialText),
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d{1,2}$|(?=^.{1,2}$)^\d+\$'),
        ),
      ],
      labelText: "Quantidade de pessoas",
      icon: Icons.people_outline_sharp,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      onChanged: (String newTotalPeople) =>
          controller.totalPeople = newTotalPeople,
      onFieldSubmitted: (String newTotalPeople) {
        controller.totalPeople = newTotalPeople;

        bool isValid = controller.totalPeople > 1;

        if (!isValid) {
          return;
        }

        if (controller.isSomeoneDrinking) {
          Navigator.of(context).pushNamed(AppRouteManager.isSomeoneDrinking);
          return;
        }
      },
    );
  }
}
