import 'package:flutter/material.dart';

class WantExitPopupWidget extends StatelessWidget {
  const WantExitPopupWidget({super.key});

  @override
  Widget build(BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Deseja sair?',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          'Você realmente deseja sair do aplicativo?',
          style: TextStyle(
            color: Colors.deepPurple[500],
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Não',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Sim',
              style: TextStyle(
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      );
}
