import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../shared/routes/app_route_manager.dart';
import '../../shared/widgets/title_text_widget.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/widgets/floating_action_button_widget.dart';
import '../../shared/widgets/subtitle_text_widget.dart';
import '../../shared/widgets/will_pop_scope_widget.dart';
import '../../shared/controllers/check_controller.dart';
import 'field/total_value_field_widget.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  late TextEditingController _textController;
  void init() {
    _textController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final controller = context.read<CheckController>();

        _textController.text = controller.totalCheckPrice;

        controller.restartCheck();

        controller.addListener(() {
          if (mounted) {
            _textController.text = controller.totalCheckPrice;
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String get titleText => 'Para começar, digite o valor total da sua conta.';

  String get subtitleText =>
      '* Precisamos do valor do recibo para dar início à divisão da sua conta.';

  @override
  Widget build(BuildContext context) {
    final CheckController controller = context.watch<CheckController>();

    return WillPopScopeWidget(
      onYesPressed: () => controller.restartCheck(),
      body: Column(
        children: [
          TitleTextWidget(
            titleText: titleText,
          ),
          const SizedBox(height: SpaceConstants.medium),
          TotalValueFieldWidget(
            controller: _textController,
            onChanged: (String newTotalCheckValue) {
              controller.totalCheckPrice = newTotalCheckValue;
            },
            onFieldSubmitted: (String newTotalCheckValue) {
              controller.totalCheckPrice = newTotalCheckValue;
              bool isValid = controller.check.totalValue > 0;
              isValid
                  ? Navigator.of(context).pushNamed(
                      AppRouteManager.totalPeople,
                    )
                  : null;
            },
          ),
          SubitleTextWidget(subtitle: subtitleText),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRouteManager.totalPeople,
        ),
        isEnabled: controller.state == CheckState.totalCheckValueValid,
      ),
    );
  }
}
