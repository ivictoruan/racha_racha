import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/core/widgets/custom_will_pop_scope_widget.dart';

import '../../controllers/total_value_controller.dart';
import '../../core/widgets/custom_drawer.dart';
import '../../core/widgets/custom_floating_action_button.dart';
import '../../core/widgets/custom_subtitle_text_widget.dart';
import '../../core/widgets/custom_title_text_widget.dart';
import 'package:racha_racha/src/core/controller/check_controller.dart';
import 'field/total_value_field.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  late final CheckController checkController;
  late final TotalValueController controller;

  void restartData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkController.restartSplit();
      controller.resetTotalCheckPrice();
    });
  }

  @override
  initState() {
    super.initState();
    checkController = context.read<CheckController>();
    controller = context.read<TotalValueController>();

    restartData();
  }

  @override
  dispose() {
    super.dispose();
    // isTotalValueFieldAutoFocusEnable = fDSalse;
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String titleText = 'Para começar, digite o valor total da sua conta';
    const String subtitleText =
        '* Precisamos do valor do recibo para dar início à divisão da sua conta.';
    const String pathToNextPage = "/totalPeople";
    return CustomWillPopWidget(
      isExitedPaged: true,
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(0.02 * size.height),
        child: SafeArea(
          child: Column(
            children: [
              const CustomTitleTextWidget(
                titleText: titleText,
              ),
              SizedBox(height: size.height * 0.04),
              Column(
                children: [
                  TotalValueField(
                    controller: checkController,
                    // autofocus: isTotalValueFieldAutoFocusEnable,
                  ),
                ],
              ),
              const CustomSubitleTextWidget(
                subtitle: subtitleText,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(
        pageToGo: pathToNextPage,
        state: CheckState.totalCheckValueValid,
      ),
    );
  }
}
