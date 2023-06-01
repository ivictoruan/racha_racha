import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'active_dot_widget.dart';
import 'first_content_widget.dart';
import 'inactive_dot_widget.dart';
import 'second_content_widget.dart';

class IntroductionWidget extends StatefulWidget {
  const IntroductionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroductionWidget> createState() => _IntroductionWidgetState();
}

class _IntroductionWidgetState extends State<IntroductionWidget> {
  int activeIndex = 0;

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
          options: CarouselOptions(
            autoPlay: true,
            height: MediaQuery.of(context).size.height * 0.75,
            autoPlayInterval: const Duration(seconds: 8),
            autoPlayAnimationDuration: const Duration(seconds: 4),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            onPageChanged: (index, reason) => setActiveDot(index),
            scrollDirection: Axis.horizontal,
            viewportFraction: 1.0,
          ),
          items: const [
            FirstContentWidget(),
            SecondContentWidget(),
          ],
        ),
        CustomDotSplider(activeIndex: activeIndex),
      ],
    );
  }
}

class CustomDotSplider extends StatelessWidget {
  final int activeIndex;

  const CustomDotSplider({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          2,
          (index) {
            return activeIndex == index
                ? const ActiveDotWidget()
                : const InactiveDotWidget();
          },
        ),
      ),
    );
  }
}
