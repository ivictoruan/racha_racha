import 'package:flutter/material.dart';

import '../../core/utils/custom_utils.dart';
import 'widgets/introduction_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  CustomUtils customUtils = CustomUtils();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/app/splash.png",
          width: size.width * 0.3,
          height: size.height * 0.15,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => customUtils.goTo(
              "/totalValue",
              context,
            ),
            icon: const Icon(
              Icons.close,
              color: Colors.purple,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          const IntroductionWidget(),
          const Spacer(
            flex: 1,
          ),
          Material(
            elevation: 2,
            shadowColor: Colors.purple,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: size.width * 0.4,
              height: size.height * 0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),

              ),
              child: TextButton(
                onPressed: () => customUtils.goTo(
                  "/totalValue",
                  context,
                ),
                child: const Text(
                  "Rachar!",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
