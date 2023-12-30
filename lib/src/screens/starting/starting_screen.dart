import 'package:flutter/material.dart';
import 'package:racha_racha/src/core/widgets/custom_will_pop_scope_widget.dart';

import '../../core/utils/custom_utils.dart';
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
    Size size = MediaQuery.sizeOf(context);
    return CustomWillPopWidget(
      isExitedPaged: true,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/app/splash.png",
          width: size.width * 0.3,
          height: size.height * 0.15,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const IntroductionWidget(),
      isBodyScrollable: false,
      floatingActionButton: const BottomRachar(),
    );
  }
}

class BottomRachar extends StatefulWidget {
  const BottomRachar({super.key});

  @override
  State<BottomRachar> createState() => _BottomRacharState();
}

class _BottomRacharState extends State<BottomRachar> {
  @override
  Widget build(BuildContext context) {
    CustomUtils customUtils = CustomUtils();

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Colors.deepPurple,
      color: Colors.deepPurple[100],
      child: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        onPressed: () => customUtils.goTo(
          "/totalValue",
          context,
        ),
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white,
        ),
        label: const Text(
          "Rachar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
