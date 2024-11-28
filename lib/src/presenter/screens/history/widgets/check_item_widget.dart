import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../domain/check/entities/check_model.dart';
import '../../../../infra/services/generate_check_service.dart';
import '../../../../infra/services/share_check_service.dart';
import '../../../shared/controllers/check_controller.dart';
import '../../../shared/constants/space_constants.dart';
import '../../../shared/routes/app_route_manager.dart';
import '../../../shared/ui/widgets/box_shadow_widget.dart';
import '../controller/history_screen_controller.dart';
import 'confirm_exclusion_popup_widget.dart';

class CheckItemWidget extends StatefulWidget {
  final CheckModel check;
  final int index;

  const CheckItemWidget({
    Key? key,
    required this.check,
    required this.index,
  }) : super(key: key);

  @override
  State<CheckItemWidget> createState() => _CheckItemWidgetState();
}

class _CheckItemWidgetState extends State<CheckItemWidget>
    with TickerProviderStateMixin {
  late final SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController(this);
  }

  @override
  void dispose() {
    _slidableController.dispose();
    super.dispose();
  }

  bool get isExpanded =>
      _slidableController.actionPaneType.value == ActionPaneType.end;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SpaceConstants.extraSmall,
          horizontal: SpaceConstants.extraSmall,
        ),
        child: Slidable(
          controller: _slidableController,
          key: ValueKey(widget.check.creationDate),
          endActionPane: ActionPane(
            extentRatio: 0.7,
            motion: const ScrollMotion(),
            children: [
              _buildShareAction(),
              _buildDeleteAction(),
            ],
          ),
          child: ListenableBuilder(
            listenable: _slidableController.animation,
            builder: (_, __) => _buildCheckContent(),
          ),
        ),
      );

  Widget _buildShareAction() => SlidableAction(
        flex: 3,
        onPressed: (_) => onSharePressed(),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Colors.white,
        icon: Icons.share,
        label: 'Compartilhar',
      );

  Widget _buildDeleteAction() => SlidableAction(
        flex: 2,
        onPressed: (_) async {
          final result = await _showDeleteConfirmationDialog();
          if (result == true) {
            onDeleteConfirmed();
          }
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.delete_forever_outlined,
        label: 'Excluir',
      );

  Widget _buildCheckContent() => BoxShadowWidget(
        isExpaded: _slidableController.animation.status.isCompleted,
        child: InkWell(
          onLongPress: onExpand,
          onTap: () => onCheckPressed(),
          borderRadius:
              isExpanded ? null : const BorderRadius.all(Radius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(SpaceConstants.medium),
            child: ListTile(
              minVerticalPadding: 0,
              dense: true,
              title: Row(
                children: [
                  Text(
                    '${widget.index}ª Divisão',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                  ),
                  Text(
                    ' $dateFormatted',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ),
              subtitle: _buildSubtitle(),
              contentPadding: EdgeInsets.zero,
              trailing: _buildExpandButton(),
            ),
          ),
        ),
      );

  Widget _buildExpandButton() => IconButton(
        onPressed: onExpand,
        icon: Icon(!isExpanded ? Icons.open_in_new_outlined : Icons.close),
        color: Colors.deepPurple,
        highlightColor: Colors.deepPurple,
      );
  Widget _buildSubtitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total: R\$ ${widget.check.totalValue.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
          ),
          Row(
            children: [
              const Icon(Icons.people_alt_outlined, color: Colors.deepPurple),
              Text(
                ' ${widget.check.totalPeople} pessoas',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
              if (widget.check.isSomeoneDrinking) ...[
                const SizedBox(width: SpaceConstants.extraSmall),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 0.5,
                      )),
                  child: Text(
                    '${widget.check.totalPeopleDrinking} bebendo',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ],
      );

  void onExpand() {
    isExpanded
        ? _slidableController.close()
        : _slidableController.openEndActionPane();
  }

  void onCheckPressed() {
    if (isExpanded) {
      _slidableController.close();
      return;
    }
    Navigator.of(context).pushNamed(
      AppRouteManager.checkDetails,
      arguments: {
        'isFinishing': false,
        'check': widget.check,
      },
    );
  }

  String get dateFormatted {
    return widget.check.creationDate != null
        ? DateFormat('dd/MM/yyyy, HH:mm').format(widget.check.creationDate!)
        : 'Data não disponível';
  }

  Future<void> onSharePressed() async {
    final image = await context
        .read<GenerateCheckService>()
        .generateImage(check: widget.check);

    if (mounted) {
      await context.read<ShareCheckService>().shareCheck(
            imageBytes: image,
          );
    }
  }

  Future<bool?> _showDeleteConfirmationDialog() => showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmExclusionPopupWidget());

  void onDeleteConfirmed() {
    context.read<CheckController>().delete(widget.check);
    context.read<HistoryScreenController>().reloadChecks();
  }
}
