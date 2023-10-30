import 'package:flutter/material.dart';

class ResultInfoWidget extends StatelessWidget {
  final String startText;
  final String endText;
  final bool isMainResult;
  const ResultInfoWidget({
    Key? key,
    required this.startText,
    required this.endText,
    this.isMainResult = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.deepPurpleAccent,
      color: isMainResult ? Colors.deepPurple[400] : Colors.white,
      child: SizedBox(
        height: 0.08 * size.height,
        child: Padding(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                startText,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isMainResult ? Colors.white : Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                'R\$ $endText',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isMainResult ? Colors.white : Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
