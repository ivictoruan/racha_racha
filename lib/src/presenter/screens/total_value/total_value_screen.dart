import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/presenter/shared/ui/constants/space_constants.dart';

import 'controller/total_value_controller.dart';
import '../../shared/widgets/custom_floating_action_button.dart';
import '../../shared/widgets/custom_subtitle_text_widget.dart';
import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../shared/widgets/custom_title_text_widget.dart';
import 'package:racha_racha/src/presenter/shared/controllers/check_controller.dart';
import 'field/total_value_field.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  late final CheckControllerImpl checkController;
  late final TotalValueController controller;

  void restartData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkController.restartCheck();
      controller.resetTotalCheckPrice();
    });
  }

  @override
  initState() {
    super.initState();
    checkController = context.read<CheckControllerImpl>();
    controller = context.read<TotalValueController>();

    restartData();
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String titleText = 'Para começar, digite o valor total da sua conta';
    const String subtitleText =
        '* Precisamos do valor do recibo para dar início à divisão da sua conta.';
    const String pathToNextPage = "/totalPeople";
    return CustomWillPopWidget(
      isExitedPaged: true,
      body: SafeArea(
        child: Column(
          children: [
            const CustomTitleTextWidget(
              titleText: titleText,
            ),
            const SizedBox(height: SpaceConstants.medium),
            Column(
              children: [
                TotalValueField(
                  // TODO! REMOVER esta dependencia do controlador, passar o que é necessário
                  controller: checkController,
                ),
              ],
            ),
            const CustomSubitleTextWidget(
              subtitle: subtitleText,
            ),
          ],
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(
        pageToGo: pathToNextPage,
        state: CheckState.totalCheckValueValid,
      ),
    );
  }
}
