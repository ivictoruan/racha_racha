import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../shared/extentions/monetary_extention.dart';
import '../../shared/input_formatters/currency_text_input_formatter.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/ui/widgets/text_form_field_widget.dart';
import '../../shared/ui/widgets/title_text_widget.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/ui/widgets/floating_action_button_widget.dart';
import '../../shared/ui/widgets/subtitle_text_widget.dart';
import '../../shared/ui/widgets/will_pop_scope_widget.dart';
import '../../shared/controllers/check_controller.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  late TextEditingController _textController;
  final _currencyFormatter = CurrencyTextInputFormatter();

  void initTextController() {
    _textController = TextEditingController();

    _textController.addListener(() {
      final formattedText = _currencyFormatter
          .formatEditUpdate(
            TextEditingValue.empty,
            TextEditingValue(text: _textController.text),
          )
          .text;

      if (formattedText != _textController.text) {
        _textController.value = TextEditingValue(
          text: formattedText,
          selection: TextSelection.collapsed(offset: formattedText.length),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initTextController();
  }

  @override
  Widget build(BuildContext context) {
    CheckController controller = context.watch<CheckController>();

    bool isTextFormFieldValid = controller.totalValue > 0 &&
        controller.state == CheckState.totalCheckValueValid;

    return WillPopScopeWidget(
      onYesPressed: () async => await onYesPressed(),
      body: Column(
        children: [
          TitleTextWidget(
            titleText: titleText,
          ),
          const SizedBox(height: SpaceConstants.medium),
          _buildTextFormField(
            controller: controller,
            enableNavigation: isTextFormFieldValid,
          ),
          SubtitleTextWidget(
            subtitle: controller.msgError.isEmpty
                ? subtitleText
                : controller.msgError,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () => Navigator.of(context).pushNamed(
          AppRouteManager.totalPeople,
        ),
        isEnabled: isTextFormFieldValid,
      ),
    );
  }

  TextFormFieldWidget _buildTextFormField({
    required CheckController controller,
    required bool enableNavigation,
  }) =>
      TextFormFieldWidget(
        hintText: 'R\$ 0,00',
        controller: _textController,
        inputFormatters: <TextInputFormatter>[
          CurrencyTextInputFormatter(),
        ],
        labelText: "Valor total da conta",
        icon: Icons.price_change_outlined,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (String newTotalCheckValue) {
          controller.totalValue = newTotalCheckValue.parseCurrency()!;
        },
        onFieldSubmitted: (String newTotalCheckValue) {
          controller.totalValue = newTotalCheckValue.parseCurrency()!;

          if (enableNavigation) {
            Navigator.of(context).pushNamed(
              AppRouteManager.totalPeople,
            );
          }
        },
      );

  String get titleText => 'Para começar, digite o valor total da sua conta.';

  String get subtitleText =>
      'Precisamos do valor do recibo para dar início à divisão da sua conta.';

  Future<void> onYesPressed() async {
    final navigator = Navigator.of(context);

    await context.read<CheckController>().restartCheck();

    if (mounted) {
      navigator.pushNamedAndRemoveUntil(
        AppRouteManager.history,
        (route) => false,
      );
    }
  }
}
