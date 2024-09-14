import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants/space_constants.dart';
import '../../../shared/controllers/check_controller.dart';

import '../../../../domain/check/entities/check_model.dart';
import 'result_info_widget.dart';

class ResultBodyWidget extends StatelessWidget {
  const ResultBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpaceConstants.screenBorder,
          ),
          child: SingleChildScrollView(
            child: Consumer<CheckController>(
              builder: (context, controller, child) {
                CheckModel model = controller.check;
                return Column(
                  children: [
                    if (model.isSomeoneDrinking) ...{
                      const SizedBox(height: SpaceConstants.medium),
                      ResultInfoWidget(
                        startText: "Se bebeu, paga:",
                        endText: model.individualPriceWhoIsDrinking
                            .toStringAsFixed(2),
                      ),
                    },
                    const SizedBox(height: SpaceConstants.medium),
                    ResultInfoWidget(
                      startText: model.isSomeoneDrinking
                          ? "Não bebeu, paga:"
                          : "Valor individual: ",
                      endText: model.individualPrice.toStringAsFixed(2),
                    ),
                    const SizedBox(height: SpaceConstants.medium),
                    if (model.waiterPercentage > 0)
                      ResultInfoWidget(
                        startText: "Valor total sem gorjeta:",
                        endText: (model.totalValue - model.totalWaiterValue)
                            .toStringAsFixed(2),
                      ),
                    const SizedBox(height: SpaceConstants.medium),
                    ResultInfoWidget(
                      startText: "Valor total:",
                      endText: model.totalValue.toStringAsFixed(2),
                    ),
                    const SizedBox(height: SpaceConstants.medium),
                    ResultInfoWidget(
                      startText: "Gorjeta:",
                      endText: model.totalWaiterValue.toStringAsFixed(2),
                    ),
                    const SizedBox(height: SpaceConstants.medium),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
