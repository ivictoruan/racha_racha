
import 'package:flutter/material.dart';

import '../constants/space_constants.dart';

class DividerWithPaddingWidget extends StatelessWidget {
  const DividerWithPaddingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: SpaceConstants.extraSmall),
          Divider(color: Colors.deepPurple[200]),
          const SizedBox(height: SpaceConstants.extraSmall),
        ],
      );
}
