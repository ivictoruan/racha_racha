import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';

class MainContentWidget extends StatelessWidget {
  final String titleContent;
  final String bodyContent;

  const MainContentWidget(
      {Key? key, required this.bodyContent, required this.titleContent})
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
        child: Column(
          children: [
            Text(
              titleContent,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple,
                fontSize: 15,
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: size.height * 0.40,
                width: size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style.copyWith(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: bodyContent,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
