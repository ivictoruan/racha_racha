import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../shared/routes/app_route_manager.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/widgets/will_pop_scope_widget.dart';
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
  void onYesPressed() async {
    await context.read<CheckController>().restartCheck();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/history',
        (route) => false,
      );
    }
  }

  void onAddCheckPressed() async {
    context.read<CheckController>().restartCheck();

    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouteManager.totalValue,
        (route) => route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) => WillPopScopeWidget(
        onYesPressed: onYesPressed,
        body: const ResultBodyWidget(),
        bottomNavigationBar: const CustomBottomNavBarWidget(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: SpaceConstants.small),
            FilledButton.tonalIcon(
              onPressed: onAddCheckPressed,
              icon: const Icon(
                Icons.add,
                color: Colors.deepPurple,
              ),
              label: const Text(
                "Dividir",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
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
