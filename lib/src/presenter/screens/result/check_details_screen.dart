import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../domain/check/entities/check.dart';
import '../../shared/routes/app_route_manager.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/controllers/check_controller.dart';
import '../../shared/ui/widgets/will_pop_scope_widget.dart';
import '../../../infra/services/generate_check_service.dart';
import '../../../infra/services/share_check_service.dart';
import 'widgets/bottom_nav_bar_widget.dart';
import 'widgets/result_body_widget.dart';
import 'widgets/shared_check_widget.dart';

class CheckDetailsScreen extends StatefulWidget {
  final bool isFinishingCheck;
  final Check check;

  const CheckDetailsScreen({
    Key? key,
    this.isFinishingCheck = true,
    required this.check,
  }) : super(key: key);

  @override
  State<CheckDetailsScreen> createState() => _CheckDetailsScreenState();
}

class _CheckDetailsScreenState extends State<CheckDetailsScreen> {
  void onYesPressed() async {
    await context.read<CheckController>().restartCheck();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouteManager.history,
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
        appBar: _buildAppBar(),
        onYesPressed: widget.isFinishingCheck ? onYesPressed : () {},
        mustShowDialog: widget.isFinishingCheck,
        body: ResultBodyWidget(check: widget.check),
        floatingActionButton: _buildFAB(),
        bottomNavigationBar: const BottomNavBarWidget(),
      );

  AppBar? _buildAppBar() => !widget.isFinishingCheck
      ? AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
          centerTitle: true,
          title: Text(
            dateFormatted,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        )
      : null;

  Widget _buildFAB() => Row(
        mainAxisAlignment: widget.isFinishingCheck
            ? MainAxisAlignment.spaceAround
            : MainAxisAlignment.center,
        children: [
          if (widget.isFinishingCheck) ...[
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
          ] else ...[
            const Spacer(),
          ],
          SharedCheckWidget(
            generateImageService: context.read<GenerateCheckService>(),
            shareService: context.read<ShareCheckService>(),
            check: widget.check,
          ),
        ],
      );

  String get dateFormatted {
    final dateFormatted = widget.check.creationDate != null
        ? DateFormat('dd/MM/yyyy, HH:mm').format(widget.check.creationDate!)
        : 'Data não disponível';
    return dateFormatted;
  }
}
