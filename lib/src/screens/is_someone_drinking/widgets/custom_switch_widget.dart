// Feel free to use the code in your projects but do not forget to give me the credits adding my app (Flutter Animation Gallery) where you are gonna use it.

import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  const CustomSwitchWidget({Key? key}) : super(key: key);

  @override
  State<CustomSwitchWidget> createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget>
    with TickerProviderStateMixin {
  bool isChecked = false;
  final Duration _duration = const Duration(milliseconds: 370);
  late final Animation<Alignment> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubicEmphasized,
        reverseCurve: Curves.easeInOutCubicEmphasized,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Center(
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(
                    () {
                      if (_animationController.isCompleted) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                      isChecked = !isChecked;
                    },
                  );
                },
                child: Container(
                  width: 100,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  decoration: BoxDecoration(
                    color: isChecked ? Colors.green : Colors.red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(99),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isChecked
                            ? Colors.green.withOpacity(0.6)
                            : Colors.red.withOpacity(0.6),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: _animation.value,
                        child: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (_animationController.isCompleted) {
                                  _animationController.reverse();
                                } else {
                                  _animationController.forward();
                                }
                                isChecked = !isChecked;
                              },
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
