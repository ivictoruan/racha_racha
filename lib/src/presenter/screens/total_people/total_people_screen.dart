import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/space_constants.dart';
import '../../shared/utils/custom_utils.dart';
import '../../shared/widgets/subtitle_text_widget.dart';
import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/widgets/text_form_field_widget.dart';
import '../../shared/widgets/title_text_widget.dart';
import '../home/view/widgets/slider_widget.dart';
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

  @override
  Widget build(BuildContext context) => CustomWillPopWidget(
        body: Column(
          children: [
            const TitleTextWidget(
              titleText: "Digite a quantidade de pessoas dividindo a conta",
            ),
            const SizedBox(height: SpaceConstants.medium),
            buildTextFormWidget(),
            const SizedBox(height: SpaceConstants.small),
            const SubitleTextWidget(
              subtitle:
                  "* Incluíndo você, digite a quantidade de pessoas dividindo a conta.",
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SubitleTextWidget(
                  subtitle: "Vai pagar taxa de Serviço/Garçom?",
                ),
                Switch(
                  value: serviceTax,
                  onChanged: (bool newValue) {
                    serviceTax = newValue;
                    controller.waiterPercentage = 0;
                    setState(() {});
                  },
                ),
              ],
            ),
            serviceTax ? const SliderWidget() : const SizedBox.shrink(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpaceConstants.extraSmall,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SubitleTextWidget(
                    subtitle: "Alguém está bebendo?",
                  ),
                  Switch(
                    value: controller.isSomeoneDrinking,
                    onChanged: (bool isSomeoneDrinking) {
                      controller.isSomeoneDrinking = isSomeoneDrinking;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: const FloatingActionButtonsWidget(),
      );

  Widget buildTextFormWidget() => TextFormFieldWidget(
        hintText: "Quantas pessoas?",
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

          CustomUtils().goTo("/isSomeoneDrinking", context);
        },
        onClearTextPressed: () => controller.totalPeople = '1',
      );
}
