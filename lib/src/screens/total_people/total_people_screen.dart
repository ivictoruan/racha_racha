import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/wigets/custom_subtitle_text_widget.dart';
import '../../core/wigets/custom_title_text_widget.dart';
import '../../core/wigets/custom_will_pop_scope_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomWillPopWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0.03 * size.height),
            child: Column(
              children: [
                const CustomTitleTextWidget(
                  titleText:
                      "👥 Digite a quantidade de pessoas dividindo a conta",
                ),
                // const CustomSmallDividerWidget(),
                SizedBox(height: size.height * 0.02),
                Consumer<CheckController>(
                  builder: (context, controller, child) {
                    return TotalPeopleFieldWidget(controller: controller);
                  },
                ),
                SizedBox(height: size.height * 0.015),
                // SizedBox(
                //     width: size.width * 0.8,
                //     child: const CustomSmallDividerWidget()),
                Consumer<CheckController>(
                  builder: (context, controller, child) {
                    return Column(
                      children: [
                        CustomSubitleTextWidget(
                            subtitle: controller.msgError == ""
                                ? '* Se você for pagar a taxa de serviço de serviço 💼, mova o ponteiro abaixo (%):'
                                : controller.msgError),
                      ],
                    );
                  },
                ),
                // SizedBox(
                //     width: size.width * 0.8,
                //     child: const CustomSmallDividerWidget()),
                SizedBox(height: size.height * 0.01),
                Consumer<CheckController>(
                  builder: (context, controller, child) {
                    bool showSlider = controller.msgError ==
                            "Incluíndo você, digite a quantidade de pessoas dividindo a conta." ||
                        controller.msgError ==
                            "❗️ A quantidade de pessoas não pode ser igual a zero!";

                    return showSlider ? const SizedBox() : const CustomSlider();
                  },
                )
              ],
            ),
          ),
        ),
        floatingActionButton: const FloatingActionButtonsWidget(),
      ),
    );
  }
}
