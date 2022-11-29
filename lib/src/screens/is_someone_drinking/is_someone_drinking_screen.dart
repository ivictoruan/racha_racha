import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/core/wigets/custom_small_divider_widget.dart';

import '../../core/wigets/custom_title_text_widget.dart';
import '../../core/wigets/custom_will_pop_scope_widget.dart';
import '../../core/wigets/wrong_total_check_value_widget.dart';
import '../home/controller/check_controller.dart';
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
  @override
  void initState() {
    super.initState();
    controller = context.read<CheckController>();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomWillPopWidget(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(0.02 * size.height),
              child: Consumer<CheckController>(
                builder: (context, controller, child) {
                  return Column(
                    children: [
                      const CustomTitleTextWidget(
                        titleText: "Alguém está bebendo?",
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                        child: const CustomSmallDividerWidget(),
                      ),
                      !controller.isSomeoneDrinking
                          ? const IsDrikingButtonsWidget()
                          : const SizedBox(),
                      !controller.isSomeoneDrinking
                          ? SizedBox(
                              height: size.height * 0.05,
                              child: const CustomSmallDividerWidget(),
                            )
                          : const SizedBox(),
                       controller.isSomeoneDrinking
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.022 * size.height),
                              child: const IsDrinkingFormFieldWidget(),
                            )
                          : const SizedBox(),
                      controller.isSomeoneDrinking
                          ? const IsDrikingButtonsWidget()
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: const WrongTotalCheckValueWidget(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
      ),
    );
  }
}
