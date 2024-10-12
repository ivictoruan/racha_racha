import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  final void Function()? onPressed;
  final bool isActivated;

  const FloatingActionButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isActivated,
  }) : super(key: key);

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  @override
  Widget build(BuildContext context) => FloatingActionButton(
        elevation: elevation,
        focusElevation: focusElevation,
        backgroundColor: backgroundColor,
        onPressed: widget.isActivated ? widget.onPressed : null,
        child: Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
      );

  Color get disabledButtonColor => const Color(0xFFE0E0E0);

  Color get activatedButtonColor => Colors.deepPurple;

  Color get backgroundColor =>
      widget.isActivated ? Colors.deepPurple : disabledButtonColor;

  IconData get icon => Icons.arrow_forward;

  double get elevation => widget.isActivated ? 2 : 0;

  double get focusElevation => 2;
}
