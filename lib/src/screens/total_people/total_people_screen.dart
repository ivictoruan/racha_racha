import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_subtitle_text_widget.dart';
import '../../core/widgets/custom_title_text_widget.dart';
import '../../core/widgets/custom_will_pop_scope_widget.dart';
import 'package:racha_racha/src/core/controller/check_controller.dart';
import '../home/view/widgets/custom_slider.dart';
import 'field/total_people_field_widget.dart';
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
    controller = Provider.of<CheckController>(context, listen: false);
    controller.msgError =
        "Incluíndo você, digite a quantidade de pessoas dividindo a conta.";
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
        children: [
          const CustomTitleTextWidget(
            titleText: "Digite a quantidade de pessoas dividindo a conta",
          ),
          SizedBox(height: size.height * 0.02),
          Consumer<CheckController>(
            builder: (context, controller, child) {
              return TotalPeopleFieldWidget(controller: controller);
            },
          ),
          SizedBox(height: size.height * 0.015),
          const Column(
            children: [
              CustomSubitleTextWidget(
                subtitle:
                    "* Incluíndo você, digite a quantidade de pessoas dividindo a conta.",
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomSubitleTextWidget(
                subtitle: "Vai pagar taxa de Serviço/Garçom?",
              ),
              Switch(
                value: serviceTax,
                onChanged: (bool newValue) {
                  setState(() {
                    serviceTax = newValue;
                    controller.waiterPercentage = 0;
                  });
                },
              ),
            ],
          ),
          serviceTax ? const CustomSlider() : const SizedBox.shrink(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomSubitleTextWidget(
                  subtitle: "Alguém está bebendo?",
                ),
                Switch(
                  value: controller.isSomeoneDrinking,
                  onChanged: (bool isSomeoneDrinking) {
                    setState(() {
                      controller.isSomeoneDrinking = isSomeoneDrinking;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButtonsWidget(),
    );
  }
}
