import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/total_people_controller.dart';
import '../../core/widgets/custom_subtitle_text_widget.dart';
import '../../core/widgets/custom_title_text_widget.dart';
import '../../core/widgets/custom_will_pop_scope_widget.dart';
import 'field/total_people_field_widget.dart';
import 'widgets/custom_slider.dart';
import 'widgets/floating_action_buttons_widget.dart';

class TotalPeopleScreen extends StatefulWidget {
  const TotalPeopleScreen({Key? key}) : super(key: key);

  @override
  State<TotalPeopleScreen> createState() => _TotalPeopleScreenState();
}

class _TotalPeopleScreenState extends State<TotalPeopleScreen> {
  late final TotalPeopleController controller;
  bool serviceTax = false;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<TotalPeopleController>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => controller.restartTotalPeople());
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String titleText = "Digite a quantidade de pessoas dividindo a conta";
    return CustomWillPopWidget(
      body: Column(
        children: [
          const CustomTitleTextWidget(
            titleText: titleText,
          ),
          SizedBox(height: size.height * 0.02),
          TotalPeopleFieldWidget(controller: controller),
          Visibility(
            visible: controller.msgError != "",
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Text(
                  controller.msgError,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          const Column(
            children: [
              CustomSubtitleTextWidget(
                subtitle:
                    "* Incluíndo você, digite a quantidade de pessoas dividindo a conta.",
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomSubtitleTextWidget(
                subtitle: "Vai pagar taxa de Serviço/Garçom?",
              ),
              Expanded(
                child: Switch(
                  value: serviceTax,
                  onChanged: (bool newValue) {
                    setState(() {
                      serviceTax = newValue;
                      controller.waiterPercentage = 0;
                    });
                  },
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: serviceTax
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: const Column(
              children: [
                CustomSlider(),
                Divider(),
              ],
            ),
            secondChild: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomSubtitleTextWidget(
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
