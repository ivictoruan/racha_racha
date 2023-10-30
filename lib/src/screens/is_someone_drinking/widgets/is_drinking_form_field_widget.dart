import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/core/widgets/custom_subtitle_text_widget.dart';

import '../../../controllers/is_someone_drinking_controller.dart';
import '../../../core/widgets/custom_title_text_widget.dart';
import '../fields/total_drink_value_field_widget.dart';
import '../fields/total_people_drinking_field_widget.dart';
import 'info_text_alert_widget.dart';

class IsDrinkingFormFieldWidget extends StatelessWidget {
  const IsDrinkingFormFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: Consumer<IsSomeoneDrinkingController>(
        builder: (context, controller, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              TotalDrinkValueFieldWidget(controller: controller),
              const CustomSubtitleTextWidget(
                subtitle:
                    "Digite os valores somados das bebidas consumidas (sem taxa de serviço).",
              ),
              SizedBox(height: size.height * 0.02),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.groups_3_sharp,
                    size: 30,
                    color: Colors.deepPurple,
                  ),
                  CustomTitleTextWidget(titleText: "Quantas pessoas beberam?"),
                ],
              ),
              const SizedBox(height: 15),
              TotalPeopleDrinkingFieldWidget(controller: controller),
              const CustomSubtitleTextWidget(
                  subtitle:
                      "Digite a quantidade de pessoas que consumiram bebidas"),
              if (controller.msgError.isNotEmpty) ...{
                SizedBox(height: size.height * 0.015),
                const InfoTextAlertWidget(),
              },
            ],
          );
        },
      ),
    );
  }
}
