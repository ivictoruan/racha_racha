import 'package:flutter/material.dart';

class ConfirmExclusionPopupWidget extends StatelessWidget {
  const ConfirmExclusionPopupWidget({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text(
          'Confirmar exclusão',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Tem certeza de que deseja excluir esta divisão?',
          style: TextStyle(
            color: Colors.deepPurple[500],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancelar',
            ),
            // style: ButtonStyle(
            //     backgroundColor: WidgetStatePropertyAll(Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Excluir',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
}
