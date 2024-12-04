import 'package:flutter/material.dart';
import '../../../shared/constants/space_constants.dart';

class ResultInfoWidget extends StatelessWidget {
  final IconData? icon;
  final bool isWithDollarSign;
  final String startText;
  final String endText;

  const ResultInfoWidget({
    Key? key,
    required this.startText,
    required this.endText,
    this.icon,
    this.isWithDollarSign = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.deepPurple[700],
          fontSize: 16,
          overflow: TextOverflow.ellipsis,
        );

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      shadowColor: Colors.deepPurpleAccent.withOpacity(0.1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: SpaceConstants.extraLarge,
        padding: const EdgeInsets.all(SpaceConstants.small),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, color: Colors.deepPurple[400]),
            const SizedBox(width: SpaceConstants.small),
            Expanded(
              child: Text(
                startText,
                style: textStyle,
              ),
            ),
            Text(
              '${isWithDollarSign ? 'R\$' : ''} $endText',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple[800],
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
