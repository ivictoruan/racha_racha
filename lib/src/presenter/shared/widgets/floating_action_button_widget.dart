import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final bool isEnabled;
  final IconData? icon;

  const FloatingActionButtonWidget({
    Key? key,
    required this.onPressed,
    required this.isEnabled,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: isEnabled
                  ? Colors.deepPurple.withOpacity(0.5)
                  : Colors.transparent,
              blurRadius: elevation,
              offset: Offset(0, elevation),
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          splashColor: Colors.white70,
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: isEnabled ? onPressed : null,
          child: Icon(
            iconData,
            size: 32,
            color: Colors.white,
          ),
        ),
      );

  Color get disabledButtonColor => const Color(0xFFE0E0E0);

  Color get activatedButtonColor => Colors.deepPurple;

  Color get backgroundColor =>
      isEnabled ? Colors.deepPurple : disabledButtonColor;

  IconData get iconData => icon ?? Icons.arrow_forward;

  double get elevation => isEnabled ? 2 : 0;

  double get focusElevation => 2;
}
