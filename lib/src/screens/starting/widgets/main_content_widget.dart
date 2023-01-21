import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MainContentWidget extends StatelessWidget {
  final String mainContent;
  const MainContentWidget({Key? key, required this.mainContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 0.25,
          width: size.width * 0.9,
          child: Markdown(
            data: mainContent,
            controller: ScrollController(),
            selectable: true,
            softLineBreak: true,
          ),
        ),
      ),
    );
  }
}
