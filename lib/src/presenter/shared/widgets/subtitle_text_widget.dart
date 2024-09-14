import 'package:flutter/material.dart';
import '../constants/space_constants.dart';

class SubitleTextWidget extends StatelessWidget {
  final String subtitle;
  const SubitleTextWidget({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SpaceConstants.medium,
            fontWeight: FontWeight.w400,
            color: Colors.deepPurple.withOpacity(0.6),
          ),
        ),
      );
}
