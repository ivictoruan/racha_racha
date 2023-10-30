import 'package:flutter/material.dart';

class SplitHistoryWidget extends StatelessWidget {
  const SplitHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    TextStyle smallTextStyle =
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w400);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        shadowColor: Colors.deepPurple,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: size.width - 20,
          height: size.height * 0.16,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.deepPurple[50],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Valor Total R\$ 750,00",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.people_alt_outlined,
                                      color: Colors.deepPurple,
                                      size: size.height * 0.03),
                                  Text("3 pessoas", style: smallTextStyle),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Row(
                                children: [
                                  Icon(Icons.date_range_outlined,
                                      color: Colors.deepPurple,
                                      size: size.height * 0.03),
                                  Text("20/05/2023 12:50",
                                      style: smallTextStyle),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.local_bar_outlined,
                                        color: Colors.deepPurple,
                                        size: size.height * 0.03),
                                    Text("R\$ 500,00", style: smallTextStyle),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  children: [
                                    Icon(Icons.food_bank_outlined,
                                        color: Colors.deepPurple,
                                        size: size.height * 0.03),
                                    Text("R\$ 250,00", style: smallTextStyle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const CircleAvatar(
                  child: Icon(
                    Icons.open_in_new_rounded,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
