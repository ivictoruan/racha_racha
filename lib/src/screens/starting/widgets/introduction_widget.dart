import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';

import 'contents/first_content_widget.dart';
import 'contents/second_content_widget.dart';
// import 'contents/third_content_widget.dart';
import 'dots/custom_dot_slider.dart';

class IntroductionWidget extends StatefulWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroductionWidget> createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget> {
  int activeIndex = 0;
  final controller = CarouselController();

  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    const String smartphoneLottie = "assets/lottie/smartphone.json";

    final List<Widget> startingItems = [
      const FirstContentWidget(),
      const SecondContentWidget(),
      // ThirdContentWidget(), // Login/Registration
    ];
    return Column(
      children: [
        Lottie.asset(
          smartphoneLottie,
          height: size.height * 0.25,
        ),
        Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            CarouselSlider(
              carouselController: controller,
              options: CarouselOptions(
                autoPlay: true,
                height: MediaQuery.sizeOf(context).height * 0.75,
                autoPlayInterval: const Duration(seconds: 15),
                autoPlayAnimationDuration: const Duration(seconds: 4),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                onPageChanged: (index, reason) => setActiveDot(index),
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
              items: startingItems,
            ),
            // const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.55),
                child: CustomDotSplider(
                  activeIndex: activeIndex,
                  controller: controller,
                  count: startingItems.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
