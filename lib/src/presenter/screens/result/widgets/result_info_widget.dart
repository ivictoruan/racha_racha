import 'package:flutter/material.dart';

import '../../../shared/constants/space_constants.dart';

class ResultInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;
  const ResultInfoWidget({
    Key? key,
    required this.startText,
    required this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle getStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Colors.deepPurple,
          fontSize: 16,
        );

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.deepPurpleAccent,
      color: Colors.white,
      child: SizedBox(
        height: SpaceConstants.extraLarge,
        child: Padding(
          padding: const EdgeInsets.all(SpaceConstants.extraSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startText,
                style: getStyle,
              ),
              Text(
                'R\$ $endText',
                style: getStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
