import 'package:flutter/material.dart';

import '../../../shared/widgets/box_shadow_widget.dart';

class SettingsButtonWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const SettingsButtonWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: BoxShadowWidget(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(
                    icon,
                    color: Colors.deepPurple,
                  ),
                  const Spacer(),
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
