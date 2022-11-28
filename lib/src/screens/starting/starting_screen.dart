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
        // toolbarHeight: size.height * 0.05,
      ),
      body: IntroductionScreen(
        curve: Curves.easeInOutCirc,
        animationDuration: 400,
        isBottomSafeArea: true,
        pages: [
          PageViewModel(
            titleWidget: Column(
              children: [
                buildImage("assets/lottie/receipt.json"),
                const Spacer(),
                const Text("'Boas-vindas ao Racha Racha!!!"),
              ],
            ),
            // body: Text('Boas-vindas ao Racha Racha!!!\nDivida a conta no seu rolê.'),
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                //   Text(
                //   'Boas-vindas ao Racha Racha!!!',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // \nDivida a conta no seu rolê.
                 Text('Divida a conta no seu rolê.'),
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
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: size.height * 0.02),
                CustomMaterialWidget(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.safety_divider_outlined),
                    label: const Text(
                      "Rachar!",
                    ),
                  ),
                ),
              ],
            ),
            image: buildImage("assets/lottie/question.json"),
            decoration: getPageDecoration(),
          ),
        ],
        onDone: () => customUtils.goTo("/totalValue", context),
        //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
        scrollPhysics: const ClampingScrollPhysics(),
        showDoneButton: true,
        showNextButton: true,
        showSkipButton: true,
        skip: const Text("Avançar",
            style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward_outlined),
        done: const Text("Ok!", style: TextStyle(fontWeight: FontWeight.w600)),
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
