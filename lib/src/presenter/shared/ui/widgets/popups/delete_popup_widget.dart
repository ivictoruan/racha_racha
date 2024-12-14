import 'package:flutter/material.dart';

class DeletePopupWidget extends StatelessWidget {
  final String text;

  const DeletePopupWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text('Excluir $text'),
        content: Text(
          'Tem certeza que deseja excluir este $text?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      );
}
