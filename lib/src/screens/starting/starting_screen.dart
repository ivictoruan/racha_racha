import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:racha_racha/src/core/utils/custom_utils.dart';
import 'package:racha_racha/src/core/wigets/custom_material_widget.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  CustomUtils customUtils = CustomUtils();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/app/splash.png",
          width: size.width * 0.3,
          height: size.height * 0.15,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => customUtils.goTo("/totalValue", context),
            icon: const Icon(
              Icons.close,
              color: Colors.purple,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: IntroductionScreen(
        showDoneButton: true,

        curve: Curves.easeInOutCubicEmphasized,
        animationDuration: 100,
        isBottomSafeArea: true,
        pages: [
          PageViewModel(
            title: "Boas-vindas ao Racha Racha!",
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildImage("assets/lottie/receipt.json"),
                SizedBox(height: size.height * 0.02),
                const Text(
                  'Rache a conta no rolê!',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Como funciona?',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'É muito simples! Digite o valor total da conta, das bebidas (se houver alguém bebendo) e quantidade de pessoas para encontrar o melhor resultado.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.02),
                // CustomMaterialWidget(
                //   child: TextButton.icon(
                //     onPressed: () => customUtils.goTo("/totalValue", context),
                //     icon: const Icon(Icons.safety_divider_outlined),
                //     label: const Text(
                //       "Rachar!",
                //     ),
                //   ),
                // ),
              ],
            ),
            image: buildImage("assets/lottie/question.json"),
            decoration: getPageDecoration(),
          ),
        ],
        //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
        scrollPhysics: const ClampingScrollPhysics(),
        showNextButton: true,
        done: Material(
          borderRadius: BorderRadius.circular(28),
          elevation: 3,
          shadowColor: Colors.purpleAccent,
          child: const CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 28,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
        onDone: () => customUtils.goTo("/totalValue", context),
        // onSkip: () => ,
        // skip: FloatingActionButton(
        //   onPressed: () {},
        //   child: const Icon(Icons.arrow_forward),
        // ),
        next: Material(
          borderRadius: BorderRadius.circular(28),
          elevation: 3,
          shadowColor: Colors.purpleAccent,
          child: const CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 28,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),

        dotsDecorator: getDotsDecorator(),
      ),
    );
  }
}

Widget buildImage(String lottiePath) {
  return Center(
    child: Lottie.asset(
      lottiePath,
      width: 450,
      height: 200,
    ),
  );
}

//method to customise the page style
PageDecoration getPageDecoration() {
  return const PageDecoration(
    imagePadding: EdgeInsets.only(top: 120),
    pageColor: Colors.white,
    bodyPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
    titlePadding: EdgeInsets.only(top: 50),
    bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
  );
}

//method to customize the dots style
DotsDecorator getDotsDecorator() {
  return const DotsDecorator(
    spacing: EdgeInsets.symmetric(horizontal: 2),
    activeColor: Colors.purple,
    color: Colors.grey,
    activeSize: Size(12, 5),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
  );
}
