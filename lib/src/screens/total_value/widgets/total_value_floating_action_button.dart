
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/controllers/total_value_controller.dart';

class TotalValueFloatingActionButton extends StatefulWidget {
  final Enum state;
  final String? pageToGo;
  final Function()? onPressed;
  final IconData? icon;
  const TotalValueFloatingActionButton({
    Key? key,
    this.pageToGo,
    this.icon,
    this.onPressed,
    required this.state,
  }) : super(key: key);

  @override
  State<TotalValueFloatingActionButton> createState() =>
      _TotalValueFloatingActionButtonState();
}

class _TotalValueFloatingActionButtonState
    extends State<TotalValueFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    void goToPage(String page) {
      GoRouter.of(context).push(page);
    }

    return Consumer<TotalValueController>(
      builder: (context, controller, child) {
        return FloatingActionButton(
          elevation: controller.state == widget.state ? 2 : 0,
          focusElevation: 2,
          backgroundColor: controller.state == widget.state
              ? Colors.deepPurple
              
              : const Color(0xFFE0E0E0),
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
            color: Colors.white,
          ),
        );
      },
    );
  }
}
