import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:racha_racha/src/controllers/total_value_controller.dart';

class TotalValueFloatingActionButton extends StatefulWidget {
  final Enum state;
  final String pageToGo;
  final Function()? onPressed;
  final IconData? icon;
  const TotalValueFloatingActionButton({
    Key? key,
    required this.state,
    required this.pageToGo,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  State<TotalValueFloatingActionButton> createState() =>
      _TotalValueFloatingActionButtonState();
}

class _TotalValueFloatingActionButtonState
    extends State<TotalValueFloatingActionButton> {

  @override
  Widget build(BuildContext context) {
    return Consumer<TotalValueController>(
      builder: (context, controller, child) {
        final bool isValid = controller.state == widget.state;
        return FloatingActionButton(
          elevation: isValid ? 2 : 0,
          focusElevation: 2,
          backgroundColor:
              isValid ? Colors.deepPurple : const Color(0xFFE0E0E0),
          onPressed: !(isValid)
              ? null
              : () {
                  widget.onPressed ??
                      debugPrint('onPressed pressionado (sem valor)');
                 GoRouter.of(context).push(widget.pageToGo);
                },
          child: Icon(
            widget.icon ?? Icons.arrow_forward,
            size: isValid ? 28 : null,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
