import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';

class MainContentWidget extends StatelessWidget {
  final String mainContent;
  const MainContentWidget({Key? key, required this.mainContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
      elevation: 1,
      shadowColor: Colors.deepPurpleAccent,
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.40,
            width: size.width * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                    children: <TextSpan>[
                      TextSpan(text: mainContent),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
