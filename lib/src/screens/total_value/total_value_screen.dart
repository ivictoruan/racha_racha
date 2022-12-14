import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/wigets/custom_floating_action_button.dart';
import '../../core/wigets/custom_small_divider_widget.dart';
import '../../core/wigets/custom_subtitle_text_widget.dart';
import '../../core/wigets/custom_title_text_widget.dart';
import '../home/controller/check_controller.dart';
import '../is_someone_drinking/widgets/info_text_alert_widget.dart';
import 'field/total_value_field.dart';

class TotalValueScreen extends StatefulWidget {
  const TotalValueScreen({Key? key}) : super(key: key);

  @override
  State<TotalValueScreen> createState() => _TotalValueScreenState();
}

class _TotalValueScreenState extends State<TotalValueScreen> {
  late final CheckController controller;
  @override
  initState() {
    super.initState();
    controller = context.read<CheckController>();
    controller.restartSplit();
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0.02 * size.height),
        child: SafeArea(
          child: Column(
            children: [
              const CustomTitleTextWidget(
                titleText:
                    'Para começar, digite o valor total da sua conta/recibo',
              ),
              SizedBox(
                  height: size.height * 0.01,
                  child: const CustomSmallDividerWidget()),
              const CustomSubitleTextWidget(
                subtitle:
                    'Precisamos dele para dar início à divisão da sua conta.',
              ),
              SizedBox(
                width: size.width * 0.8,
                child: const CustomSmallDividerWidget(),
              ),
              SizedBox(height: size.height * 0.04),
              Consumer<CheckController>(
                builder: (context, controller, child) {
                  return Column(
                    children: [
                      TotalValueField(controller: controller),
                      SizedBox(height: 0.015 * size.height),
                      controller.msgError != ""
                          ? const InfoTextAlertWidget()
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomFloatingActionButton(
        pageToGo: "/totalPeople",
        state: CheckState.totalCheckValueValid,
      ),
    );
  }
}
