import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/check_controller.dart';


class CustomFloatingActionButton extends StatefulWidget {
  final Enum state;
  final String? pageToGo;
  final Function()? onPressed;
  final IconData? icon;
  const CustomFloatingActionButton({
    Key? key,
    this.pageToGo,
    this.icon,
    this.onPressed,
    required this.state,
  }) : super(key: key);

  @override
  State<CustomFloatingActionButton> createState() =>
      _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState
    extends State<CustomFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void goToPage(String page) {
      GoRouter.of(context).push(page);
    }

    return Consumer<CheckController>(
      builder: (context, controller, child) {
        return FloatingActionButton(
          hoverColor: Colors.purple.withOpacity(0.6),
          elevation: controller.state == widget.state ? 5 : 0,
          // focusElevation: 2,
          backgroundColor: controller.state == widget.state
              ? Colors.purple
              : Colors.purple.withOpacity(0.1),
          onPressed: !(controller.state == widget.state)
              ? null
              : () {
                  widget.onPressed ??
                      debugPrint('onPressed pressionado (sem valor)');
                  goToPage(widget.pageToGo!);
                },
          child: Icon(
            widget.icon ?? Icons.arrow_forward,
            size: 0.04 * size.height,
          ),
        );
      },
    );
  }
}
