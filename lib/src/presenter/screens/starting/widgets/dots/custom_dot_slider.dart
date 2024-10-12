import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    show AnimatedSmoothIndicator, ExpandingDotsEffect;

import '../../../../shared/constants/space_constants.dart';

class CustomDotSplider extends StatelessWidget {
  final int activeIndex;
  final carousel.CarouselController controller;
  final int count;

  const CustomDotSplider({
    super.key,
    required this.controller,
    required this.activeIndex,
    required this.count,
  });

  void animateToSlide(int index) => controller.animateToPage(index);

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedSmoothIndicator(
          onDotClicked: animateToSlide,
          effect: const ExpandingDotsEffect(
            dotWidth: SpaceConstants.extraSmall,
            dotHeight: SpaceConstants.extraSmall,
            dotColor: Colors.deepPurple,
            activeDotColor: Colors.deepPurple,
          ),
          activeIndex: activeIndex,
          count: count,
        ),
      );
}
