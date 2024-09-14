import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/utils/custom_utils.dart';
import '../../shared/widgets/title_text_widget.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/widgets/floating_action_button_widget.dart';
import '../../shared/widgets/subtitle_text_widget.dart';
import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../shared/controllers/check_controller.dart';
import 'field/total_value_field_widget.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  void restartData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CheckController>().restartCheck();
    });
  }

  @override
  initState() {
    super.initState();

    restartData();
  }

  String get titleText => 'Para começar, digite o valor total da sua conta.';

  String get subtitleText =>
      '* Precisamos do valor do recibo para dar início à divisão da sua conta.';

  String get pathToNextPage => "/totalPeople";

  @override
  Widget build(BuildContext context) {
    final CheckController controller = context.watch<CheckController>();

    return CustomWillPopWidget(
      isExitedPaged: true,
      body: SafeArea(
        child: Column(
          children: [
            // TODO: implantar TitleTextWidget em TotalValueFieldWidget de e expor
            /// ´titleText´ como parâmetro
            TitleTextWidget(
              titleText: titleText,
            ),
            const SizedBox(height: SpaceConstants.medium),
            Column(
              children: [
                TotalValueFieldWidget(
                  onChanged: (String newTotalCheckValue) {
                    // final double? parsedValue =
                    //     parsedNewTotalCheckValue(newTotalCheckValue);

                    // if (parsedValue == null) {
                    //   return;
                    // }

                    controller.totalCheckPrice = newTotalCheckValue;
                  },
                  onFieldSubmitted: (String newTotalCheckValue) {
                    // final double? parsedValue =
                    //     parsedNewTotalCheckValue(newTotalCheckValue);

                    // if (parsedValue == null || parsedValue > 0) {
                    //   return;
                    // }
                    CustomUtils customUtils = CustomUtils();
                    controller.totalCheckPrice = newTotalCheckValue;
                    bool isValid = controller.check.totalValue > 0;
                    isValid ? customUtils.goTo("/totalPeople", context) : null;
                  },
                ),
              ],
            ),
            // TODO: implantar CustomSubitleTextWidget em TotalValueFieldWidget de e expor ´titleText´ como parâmetro
            SubitleTextWidget(
              subtitle: subtitleText,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => CustomUtils().goTo(pathToNextPage, context),
        isActivated: controller.state == CheckState.totalCheckValueValid,
      ),
    );
  }
}
