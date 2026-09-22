import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../../domain/check/entities/check.dart';
import '../../../domain/check/usecases/share_check.dart';
import '../../shared/controllers/split_screen_controller.dart';
import '../../shared/constants/space_constants.dart';
import '../../shared/ui/extentions/monetary_extentions.dart';
import '../add_item/add_item_screen.dart';
import '../add_participant_screen.dart';
import 'widget/initial_participants_popup_widget.dart';
import 'widget/item_list_widget.dart';
import 'widget/participant_list_widget.dart';

class SplitScreen extends StatefulWidget {
  final Check? check;
  const SplitScreen({super.key, this.check});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  late final SplitScreenController controller;

  get conts => null;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<SplitScreenController>(context, listen: false);

    log('widget.check: ${widget.check}');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.check != null) {
        controller.loadCheck(widget.check!);
      } else {
        final result = await InitialParticipantsPopupWidget.show(context);
        if (result != true && controller.participants.isEmpty && mounted) {
          Navigator.of(context).pop(false);
        }
      }
    });
  }

  Future<bool> _saveAndNotify() async {
    final controller = context.read<SplitScreenController>();
    final success = await controller.createCheck();
    if (!mounted) return false;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Divisão salva com sucesso!' : 'Erro ao salvar divisão.',
        ),
        backgroundColor: !success ? Colors.red : null,
      ),
    );
    return success;
  }

  Future<void> _handleBack() async {
    final navigator = Navigator.of(context);
    final controller = context.read<SplitScreenController>();

    if (!controller.hasChanges) {
      navigator.pop(false);
      return;
    }

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Salvar Divisão'),
        content: const Text('Deseja salvar as alterações antes de sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'discard'),
            child: const Text(
              'Sair sem salvar',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, 'save'),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (result == 'save') {
      final success = await _saveAndNotify();
      if (success && mounted) {
        navigator.pop(true);
      }
    } else if (result == 'discard') {
      navigator.pop(false);
    }
  }

  Future<void> saveCheck() async {
    final success = await _saveAndNotify();
    if (success && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  Future<void> _shareCheck() async {
    final controller = context.read<SplitScreenController>();
    final shareCheckUseCase = context.read<ShareCheck>();

    final check = Check(
      id: controller.id,
      creationDate: controller.creationDate ?? DateTime.now(),
      items: controller.items.toList(),
      participants: controller.participants.toList(),
    );

    final result = await shareCheckUseCase.call(check: check);

    if (!mounted) return;

    final isSuccess = result.fold((l) => false, (r) => r);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSuccess
              ? 'Divisão compartilhada com sucesso!'
              : 'Não foi possível compartilhar a divisão.',
        ),
        backgroundColor: !isSuccess ? Colors.red : null,
      ),
    );
  }

  bool checkIfMustSave() {
    final controller = context.watch<SplitScreenController>();
    if (controller.participants.isEmpty || controller.items.isEmpty) {
      return false;
    }

    return controller.hasChanges;
  }

  bool canShare() {
    final controller = context.watch<SplitScreenController>();
    return controller.participants.isNotEmpty && controller.items.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: _handleBack,
          ),
          title: Text(
            widget.check != null ? "Editar Divisão" : "Nova Divisão",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            if (canShare()) ...{
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 26,
                ),
                tooltip: 'Compartilhar divisão',
                onPressed: _shareCheck,
              ),
            },
          ],
          elevation: 4,
          shadowColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: SpaceConstants.medium),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceConstants.medium,
                  vertical: SpaceConstants.small,
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Valor total da conta',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                        context
                            .watch<SplitScreenController>()
                            .totalValue
                            .toCurrency(),
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              const SizedBox(height: SpaceConstants.medium),
              Text('Itens consumidos',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              const Expanded(
                flex: 1,
                child: ItemListWidget(),
              ),
              const SizedBox(height: SpaceConstants.medium),
              Text('Participantes',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              const Expanded(
                flex: 1,
                child: ParticipantListWidget(),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 2),
            Visibility(
              visible: checkIfMustSave(),
              child: FloatingActionButton.extended(
                onPressed:
                    checkIfMustSave() ? () async => await saveCheck() : null,
                label: const Text('Salvar'),
                icon: const Icon(Icons.save),
              ),
            ),
            const Spacer(),
            _buildSpeedDial(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedDial() => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SpeedDial(
          icon: Icons.add_to_photos_rounded,
          activeIcon: Icons.close,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          spacing: 8,
          spaceBetweenChildren: 8,
          direction: SpeedDialDirection.up,
          children: [
            SpeedDialChild(
              labelStyle: const TextStyle(fontSize: 18),
              child: const Icon(
                Icons.person_add_alt,
                color: Colors.deepPurple,
              ),
              label: 'Adicionar Participante',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<SplitScreenController>(),
                      child: const AddParticipantScreen(),
                    ),
                  ),
                );
              },
            ),
            SpeedDialChild(
              labelStyle: const TextStyle(fontSize: 18),
              child: const Icon(
                Icons.add_shopping_cart_rounded,
                color: Colors.deepPurple,
              ),
              label: 'Adicionar Item',
              onTap: () {
                if (context
                    .read<SplitScreenController>()
                    .participants
                    .isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Adicione pelo menos um participante para adicionar itens!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider.value(
                      value: context.read<SplitScreenController>(),
                      child: const AddItemScreen(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
