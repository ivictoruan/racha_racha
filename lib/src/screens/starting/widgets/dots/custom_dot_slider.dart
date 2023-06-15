import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomDotSplider extends StatelessWidget {
  final int activeIndex;
  final CarouselController controller;
  final int count;

  const CustomDotSplider(
      {super.key, required this.controller, required this.activeIndex, required this.count});

  @override
  Widget build(BuildContext context) {
    void animateToSlide(int index) => controller.animateToPage(index);

    return Center(
      child: AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const ExpandingDotsEffect(
            dotWidth: 8,
            dotHeight: 8,
            dotColor: Colors.deepPurple,
            activeDotColor: Colors.deepPurple),
        activeIndex: activeIndex,
        count: count,
      ),
    );
  }
}
