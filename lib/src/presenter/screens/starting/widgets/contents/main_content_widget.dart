import 'package:flutter/material.dart';
import '../../../../shared/constants/space_constants.dart';

class MainContentWidget extends StatelessWidget {
  final String titleContent;
  final String bodyContent;

  const MainContentWidget({
    Key? key,
    required this.bodyContent,
    required this.titleContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: SpaceConstants.screenBorder),
        child: Material(
          elevation: 1,
          shadowColor: Colors.deepPurpleAccent,
          color: Colors.white,
          borderRadius: BorderRadius.circular(SpaceConstants.extraSmall),
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  titleContent,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: 340,
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: bodyContent,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
