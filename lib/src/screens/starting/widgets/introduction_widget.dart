import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    return Stack(
      children: [
        CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
            // TODO: ativar autoplay
            autoPlay: true,
            height: MediaQuery.sizeOf(context).height * 0.75,
            autoPlayInterval: const Duration(seconds: 15),
            autoPlayAnimationDuration: const Duration(seconds: 4),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            onPageChanged: (index, reason) => setActiveDot(index),
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),
          items: const [
            FirstContentWidget(),
            SecondContentWidget(),
            // ThirdContentWidget(), // Login/Registration
          ],
        ),
        // const Spacer(),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.75),
          child: CustomDotSplider(
            activeIndex: activeIndex,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
