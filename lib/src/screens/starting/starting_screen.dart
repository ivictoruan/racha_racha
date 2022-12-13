import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/custom_utils.dart';

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
      body: IntroductionScreen(
        showDoneButton: true,
        curve: Curves.easeInOutCubicEmphasized,
        animationDuration: 100,
        isBottomSafeArea: true,
        pages: [
          PageViewModel(
            titleWidget: Text(
              "Boas-vindas ao Racha Racha!",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 0.06 * size.width,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                buildImage("assets/lottie/receipt.json", size),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Rache a conta no rolê!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 0.04 * size.width,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            decoration: getPageDecoration(size),
          ),
          PageViewModel(
            titleWidget: Text(
              "Vamos lá?",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 0.06 * size.width,
                fontWeight: FontWeight.bold,
              ),
            ),
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildImage("assets/lottie/question.json", size),
                Text(
                  'É muito simples! Digite o valor total da conta, das bebidas (se houver alguém bebendo) e quantidade de pessoas para encontrar o melhor resultado.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 0.04 * size.width,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
            decoration: getPageDecoration(size),
          ),
        ],
        //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
        scrollPhysics: const ClampingScrollPhysics(),
        showNextButton: true,
        done: const CustomDoneWidget(),
        next: const CustomDoneWidget(),
        onDone: () => customUtils.goTo("/totalValue", context),
        dotsDecorator: getDotsDecorator(size),
      ),
    );
  }
}

Widget buildImage(String lottiePath, Size size) {
  return Center(
    child: Lottie.asset(
      lottiePath,
      width: 0.68 * size.width,
      height: 0.3 * size.height,
    ),
  );
}

//method to customise the page style
PageDecoration getPageDecoration(Size size) {
  return PageDecoration(
    imagePadding: EdgeInsets.only(top: 0.35 * size.width),
    pageColor: Colors.white,
    bodyPadding: EdgeInsets.only(
        top: 0.023 * size.width,
        left: 0.058 * size.width,
        right: 0.058 * size.width),
    titlePadding: EdgeInsets.only(top: 0.147 * size.width),
    bodyTextStyle: TextStyle(
      color: Colors.black54,
      fontSize: 0.044 * size.width,
    ),
  );
}

//method to customize the dots style
DotsDecorator getDotsDecorator(Size size) {
  return DotsDecorator(
    spacing: EdgeInsets.symmetric(
      horizontal: 0.0058823529411764705 * size.width,
    ),
    activeColor: Colors.purple,
    color: Colors.grey,
    activeSize: Size(0.06 * size.width, 0.0075 * size.height),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          25.0 * size.width,
        ),
      ),
    ),
  );
}

class CustomDoneWidget extends StatelessWidget {
  const CustomDoneWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(0.08 * size.width),
      elevation: 3,
      child: CircleAvatar(
        backgroundColor: Colors.purple,
        radius: 0.08 * size.width,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}
