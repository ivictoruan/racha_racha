import 'package:flutter/material.dart';

import '../../core/widgets/custom_will_pop_scope_widget.dart';
import '../../core/widgets/racha_main_widget.dart';
import 'widgets/bottom_rachar_widget.dart';
import 'widgets/introduction_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CustomWillPopWidget(
      isExitedPaged: true,
      appBar: AppBar(
        title: const RachaMainWidget(
          widthPercentage: 0.3,
          heightPercentage: 0.15,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const IntroductionWidget(),
      isBodyScrollable: false,
      floatingActionButton: const BottomRacharWidget(),
    );
  }
}
