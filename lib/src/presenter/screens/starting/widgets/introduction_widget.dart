import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/constants/app_assets.dart';
import '../../../shared/constants/space_constants.dart';
import 'contents/first_content_widget.dart';
import 'contents/second_content_widget.dart';
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
  final carousel.CarouselSliderController controller = carousel.CarouselSliderController();

  void setActiveDot({required int index}) {
    activeIndex = index;
    setState(() {});
  }

  final List<Widget> startingItems = [
    const FirstContentWidget(),
    const SecondContentWidget(),
  ];


  double get lottieHeight => 200;

  double get carouselHeight => 500;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Lottie.asset(
            AppAssets.smartphone,
            height: 200,
          ),
          Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              carousel.CarouselSlider(
                carouselController: controller,
                options: carousel.CarouselOptions(
                  autoPlay: true,
                  height: carouselHeight,
                  autoPlayInterval: const Duration(seconds: 15),
                  autoPlayAnimationDuration: const Duration(seconds: 4),
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  onPageChanged: (int index, _) => setActiveDot(index: index),
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                ),
                items: startingItems,
              ),
              Positioned(
                bottom: SpaceConstants.extraLarge,
                left: 0,
                right: 0,
                child: CustomDotSplider(
                  activeIndex: activeIndex,
                  controller: controller,
                  count: startingItems.length,
                ),
              ),
            ],
          ),
        ],
      );
}
