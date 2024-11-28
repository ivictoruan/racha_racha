import 'package:flutter/material.dart';

import '../../constants/space_constants.dart';

class BoxShadowWidget extends StatelessWidget {
  final Widget child;
  final bool isExpaded;
  const BoxShadowWidget({
    Key? key,
    required this.child,
    this.isExpaded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        elevation: isExpaded ? 0 : 2,
        shadowColor: Colors.deepPurpleAccent,
        color: Colors.white,
        borderRadius: isExpaded
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(SpaceConstants.medium),
                topLeft: Radius.circular(SpaceConstants.medium),
              )
            : BorderRadius.circular(SpaceConstants.medium),
        child: child,
      );
}
