import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/check/entities/check.dart';
import '../../../shared/controllers/check_controller.dart';

class SharedCheckWidget extends StatefulWidget {
  final Check check;

  const SharedCheckWidget({
    Key? key,
    required this.check,
  }) : super(key: key);

  @override
  State<SharedCheckWidget> createState() => _SharedCheckWidgetState();
}

class _SharedCheckWidgetState extends State<SharedCheckWidget> {
  @override
  Widget build(BuildContext context) => Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.deepPurpleAccent,
        color: Colors.white,
        child: FloatingActionButton.extended(
          focusColor: const Color.fromARGB(255, 247, 243, 247),
          backgroundColor: Colors.white,
          icon: const Icon(Icons.share, color: Colors.deepPurple),
          label: Text(
            "Compartilhar",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          onPressed: () async => await onSharePressed(),
        ),
      );

  Future<void> onSharePressed() async {
    final result =
        await context.read<CheckController>().shareCheck(widget.check);

    if (!mounted) return;
    final messageText = 'A divisão ${(result) ? '' : 'não'} foi compartilhada!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          messageText,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        backgroundColor: !result ? Colors.red : null,
      ),
    );
  }
}
