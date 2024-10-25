import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/constants/space_constants.dart';
import '../../shared/utils/custom_utils.dart';
import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../../infra/services/generate_check_service.dart';
import '../../../infra/services/share_check_service.dart';
import 'widgets/custom_bottom_nav_bar_widget.dart';
import 'widgets/result_body_widget.dart';
import 'widgets/shared_options_widget.dart';

class CheckResultScreen extends StatefulWidget {
  const CheckResultScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckResultScreen> createState() => _CheckResultScreenState();
}

class _CheckResultScreenState extends State<CheckResultScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomWillPopWidget(
      body: const ResultBodyWidget(),
      bottomNavigationBar: const CustomBottomNavBarWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // TODO: componentizar como SecondaryIconButtonWidget
          const SizedBox(width: SpaceConstants.small),

          FilledButton.tonalIcon(
            onPressed: () async =>
                await _showModalRestartCheck(context: context),
            icon: const Icon(
              Icons.restart_alt_rounded,
              color: Colors.grey,
            ),
            label: const Text(
              "Reiniciar",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: SpaceConstants.small),
          SharedCheckOptionsWidget(
            generateImageService: context.read<GenerateCheckService>(),
            shareService: context.read<ShareCheckService>(),
          ),
        ],
      ),
    );
  }

  Future<void> _showModalRestartCheck({
    required BuildContext context,
  }) async =>
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Gostaria de recomeçar?",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpaceConstants.extraSmall),
              Text(
                "Se você não quer reiniciar toque em \"Não\"",
                style: TextStyle(
                  color: Colors.deepPurple[200],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SpaceConstants.extraSmall),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SpaceConstants.medium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () => CustomUtils().goTo(
                      "/totalValue",
                      context,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Sim'),
                  ),
                  const SizedBox(width: SpaceConstants.extraSmall),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Não'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
