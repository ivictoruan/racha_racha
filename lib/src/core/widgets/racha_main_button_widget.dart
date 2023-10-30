import 'package:flutter/material.dart';

class RachaMainButtonWidget extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final IconData icon;

  const RachaMainButtonWidget({
    super.key,
    required this.onPressed,
    required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.deepPurpleAccent,
      color: Colors.white,
      child: FloatingActionButton.extended(
        focusColor: const Color.fromARGB(255, 247, 243, 247),
        backgroundColor: Colors.white,
        onPressed: onPressed,
        icon:  Icon(icon, color: Colors.deepPurple),
        label: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.deepPurple,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
