import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import '../helper/color_pallet.dart';
import '../controllers/score_controller.dart';
import '../helper/responsive.dart';

class BlackBoard extends StatefulWidget {
  const BlackBoard({super.key});

  @override
  State<BlackBoard> createState() => _BlackBoardState();
}

class _BlackBoardState extends State<BlackBoard> with ColorPallet {
  bool startNext = false;
  bool startNextNext = false;
  bool startNextNextNext = false;
  bool showTop5 = false;
  ScoreController scoreController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: reponsiveBlackBoardWidth(context),
          height: responsiveBlackBoardHeight(context),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withOpacity(0.3),
                  Colors.orange.withOpacity(0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]),
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    blackBoardColor2,
                    blackBoardColor1,
                    blackBoardColor2,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontFamily: 'NotoSerifEthiopic',
                  fontSize: 12,
                ),
                child: Column(
                  children: [
                    Visibility(
                      visible: !showTop5,
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        onFinished: () {
                          setState(() {
                            startNext = true;
                          });
                        },
                        animatedTexts: [
                          TyperAnimatedText(
                            'ሰሌዳ ታይፒንግ',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 200),
                            textStyle: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: startNext,
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            startNextNext = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'ሰሌዳ ታይፒንግ የመጀመሪያው የአማርኛ ፅሁፍ መለማመጃ ዌብሳይት ነው።',
                            speed: const Duration(milliseconds: 100),
                            curve: Curves.easeOut,
                            textAlign: TextAlign.left,
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: startNextNext,
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            startNextNextNext = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'አላማውም እንደ ላቲን ፊደላት በቀላሉ እና በፍጥነት የአማርኛ ፊደላትን መፃፍ ማስቻል ነው።',
                            speed: const Duration(milliseconds: 100),
                            curve: Curves.easeInOut,
                            textAlign: TextAlign.left,
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: startNextNextNext,
                      child: AnimatedTextKit(
                        onTap: () {},
                        onFinished: () {
                          setState(() {
                            startNext = false;
                            startNextNext = false;
                            startNextNextNext = false;
                            showTop5 = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'Developed By Melloss',
                            speed: const Duration(milliseconds: 200),
                            curve: Curves.bounceOut,
                            textAlign: TextAlign.end,
                            textStyle: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder(
                      stream: scoreController.fetchTop5Scrore(),
                      builder:
                          ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(
                            'ዳታውን ማግኘት አልቻለም: ${snapshot.error}',
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                            style: Theme.of(context).textTheme.displayMedium,
                          );
                        }

                        scoreController.getTop5Scores();
                        // Text(snapshot.data!['userName'].toString()),
                        //   Text(snapshot.data!['accuracy'].toString()),
                        //   Text(snapshot.data!['speed'].toString()),

                        return Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                    '${data['userName']}${data['speed']}WPM ${data['accuracy']}%'),
                              ],
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 20,
          child: Container(
            width: 20,
            height: 4,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Positioned(
          bottom: 9,
          left: 55,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 2,
                color: Colors.white.withOpacity(0.6),
              ),
              Container(
                width: 40,
                height: 8,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            width: 16,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius:
                    const BorderRadius.only(topRight: Radius.circular(10))),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 50,
          child: Container(
            width: 20,
            height: 4,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
