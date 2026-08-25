import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/controllers/split_screen_controller.dart';
import '../../../shared/ui/text/text_styles.dart';

class InitialParticipantsPopupWidget extends StatefulWidget {
  const InitialParticipantsPopupWidget({super.key});

  static Future<bool?> show(BuildContext context) {
    final controller = context.read<SplitScreenController>();
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ChangeNotifierProvider.value(
        value: controller,
        child: const InitialParticipantsPopupWidget(),
      ),
    );
  }

  @override
  State<InitialParticipantsPopupWidget> createState() =>
      _InitialParticipantsPopupWidgetState();
}

class _InitialParticipantsPopupWidgetState
    extends State<InitialParticipantsPopupWidget> {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addParticipant() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final controller = context.read<SplitScreenController>();
    final alreadyExists = controller.participants.any(
      (p) => p.name.trim().toLowerCase() == name.toLowerCase(),
    );

    if (alreadyExists) {
      setState(() {
        _errorMessage = 'Já existe um participante com esse nome!';
      });
      return;
    }

    controller.addParticipant(name);
    _nameController.clear();
    setState(() {
      _errorMessage = null;
    });
    _focusNode.requestFocus();
  }

  void _handleContinue(SplitScreenController controller) {
    if (controller.participants.isEmpty) {
      final textInField = _nameController.text.trim();
      if (textInField.isNotEmpty) {
        _addParticipant();
        if (controller.participants.isNotEmpty) {
          Navigator.pop(context, true);
          return;
        }
      }
      setState(() {
        _errorMessage = 'Adicione pelo menos um participante!';
      });
      _focusNode.requestFocus();
      return;
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SplitScreenController>();

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quem vai dividir a conta?',
            style: TextStyles.mediumTextBold(
              color: Colors.deepPurple[900]!,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Adicione os participantes para começar a divisão.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    focusNode: _focusNode,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    onChanged: (_) {
                      if (_errorMessage != null) {
                        setState(() {
                          _errorMessage = null;
                        });
                      }
                    },
                    onSubmitted: (_) => _addParticipant(),
                    decoration: InputDecoration(
                      hintText: 'Nome do participante',
                      errorText: _errorMessage,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: _addParticipant,
                  tooltip: 'Adicionar',
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (controller.participants.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    'Nenhum participante adicionado ainda.\nDigite o nome e toque em +',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            else ...[
              Text(
                'Participantes (${controller.participants.length}):',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 140),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children:
                        controller.participants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final participant = entry.value;
                      return Chip(
                        label: Text(
                          participant.name,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.deepPurple[900],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        backgroundColor: Colors.deepPurple[50],
                        deleteIcon: const Icon(Icons.close, size: 16),
                        deleteIconColor: Colors.deepPurple[400],
                        onDeleted: () => controller.removeParticipant(index),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Colors.deepPurple.withValues(alpha: 0.2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Cancelar',
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _handleContinue(controller),
          child: const Text('Continuar'),
        ),
      ],
    );
  }
}
