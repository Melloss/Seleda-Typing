import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import '../helper/color_pallet.dart';
import '../controllers/score_controller.dart';
import '../helper/responsive.dart';

class BlackBoard extends StatefulWidget {
  const BlackBoard({super.key});

  @override
  State<BlackBoard> createState() => _BlackBoardState();
}

class _BlackBoardState extends State<BlackBoard>
    with ColorPallet, TickerProviderStateMixin {
  bool startNext = false;
  bool startNextNext = false;
  bool startNextNextNext = false;
  bool showTop5 = false;
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();
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
                      visible: showTop5,
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'Top 5 Scores',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 200),
                            textStyle: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
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
                    Visibility(
                        visible: !showTop5, child: const SizedBox(height: 30)),
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
                    Visibility(
                        visible: !showTop5, child: const SizedBox(height: 20)),
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
                    const SizedBox(height: 30),
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
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
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
                          return SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20.0,
                            controller: AnimationController(
                                vsync: this,
                                duration: const Duration(milliseconds: 1200)),
                          );
                        }

                        scoreController.getTop5Scores();

                        return Visibility(
                          visible: showTop5,
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '${getGeezNumber(i + 1)}.',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                          const SizedBox(width: 15),
                                          Text(
                                            '${snapshot.data!.docs[i]['userName']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${snapshot.data!.docs[i]['speed']}WPM',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      Text(
                                        '${snapshot.data!.docs[i]['accuracy']}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                        // return Visibility(
                        //   visible: showTop5,
                        //   child: Column(
                        //     children: snapshot.data!.docs
                        //         .map((DocumentSnapshot document) {
                        //       Map<String, dynamic> data =
                        //           document.data() as Map<String, dynamic>;

                        //       return Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceAround,
                        //             children: [
                        //               Text(
                        //                 '${data['userName']}',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .displayMedium,
                        //               ),
                        //               Text(
                        //                 '${data['speed']}WPM',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .displayMedium,
                        //               ),
                        //               Text(
                        //                 '${data['accuracy']}%',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .displayMedium,
                        //               ),
                        //             ],
                        //           ),
                        //           const SizedBox(height: 10),
                        //         ],
                        //       );
                        //     }).toList(),
                        //   ),
                        // );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 29,
          left: 9,
          right: 9,
          bottom: 9,
          child: Signature(
            color: inactiveColor, // Color of the drawing path
            strokeWidth: 3.0, // with
            backgroundPainter:
                null, // Additional custom painter to draw stuff like watermark
            onSign: null, // Callback called on user pan drawing
            key: _signatureKey,
            // key that allow you to provide a GlobalKey that'll let you retrieve the image once user has signed
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
          child: InkWell(
            onTap: () {
              _signatureKey.currentState?.clear();
            },
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

  getGeezNumber(int number) {
    if (number == 1) {
      return '፩';
    } else if (number == 2) {
      return '፪';
    } else if (number == 3) {
      return '፫';
    } else if (number == 4) {
      return '፬';
    }
    return '፭';
  }
}
