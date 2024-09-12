import 'package:flutter/material.dart';

import '../../shared/widgets/custom_will_pop_scope_widget.dart';
import '../../shared/constants/space_constants.dart';
import 'widgets/go_to_rachar_button_widget.dart';
import 'widgets/introduction_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => CustomWillPopWidget(
        isExitedPaged: true,
        appBar: buildAppBar,
        body: const IntroductionWidget(),
        isBodyScrollable: false,
        floatingActionButton: const GoToRacharButtonWidget(),
      );

  PreferredSizeWidget get buildAppBar => AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: SpaceConstants.large),
          child: Image.asset(
            "assets/images/app/splash.png",
            width: 240,
            height: 120,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      );
}
