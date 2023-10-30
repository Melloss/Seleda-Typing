import 'package:flutter/material.dart';
import './helper/color_pallet.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import '/home.dart';
import 'controllers/database_controller.dart';
import 'controllers/score_controller.dart';
import './widgets/end_drawer.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> with ColorPallet {
  List<bool> isActive = [true, false, false, false, false, false];
  bool startNext = false;
  bool startNextNext = false;
  bool startNextNextNext = false;
  bool isDisabled = false;
  int randomNumber = 0;
  int selectedTime = 10;
  ScoreController scoreController = Get.find();
  DatabaseController databaseController = Get.find();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(actions: [
        _buildAccountButton(),
      ]),
      endDrawer: const EndDrawer(),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildBlackBoard(),
          Expanded(child: Container()),
          _buildOptionPane(),
          _buildScoreResult(),
          Expanded(child: Container()),
          _buildPlayButton(),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  _buildOptionPane() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        color: optionBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTextButton(0, 'ፊደል'),
          _buildTextButton(1, 'ቁጥር'),
          _buildTextButton(2, 'ሥ-ነጥብ'),
          Expanded(child: Container()),
          const VerticalDivider(),
          Expanded(child: Container()),
          _buildTextButton(3, '፲'),
          _buildTextButton(4, '፳'),
          _buildTextButton(5, '፴'),
        ],
      ),
    );
  }

  _buildTextButton(int index, String text) {
    return SizedBox(
      width: 55,
      child: TextButton(
        onPressed: () {
          if (index > 2) {
            for (int i = 3; i <= 5; i++) {
              if (isActive[index] == false) {
                if (index == i) {
                  isActive[i] = true;
                } else {
                  isActive[i] = false;
                }
              } else {
                isActive[i] = false;
              }
            }
            setState(() {
              isActive = isActive;
            });

            print(isActive[index]);
          } else {
            setState(() {
              isActive[index] = index == 0 ? true : !isActive[index];
            });
          }
        },
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(isActive[index]
                ? primaryColor
                : inactiveColor.withOpacity(0.3))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
          index > 2 ? const SizedBox(height: 1.5) : const SizedBox.shrink(),
          Visibility(
            visible: index > 2,
            child: Text(
              index == 3 ? "Seconds" : "Minutes",
              style: const TextStyle(
                fontSize: 7,
              ),
            ),
          )
        ]),
      ),
    );
  }

  _buildBlackBoard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.45,
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
              padding: const EdgeInsets.only(top: 5, left: 8),
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 12,
                ),
                child: Column(
                  children: [
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      displayFullTextOnTap: true,
                      onFinished: () {
                        setState(() {
                          startNext = true;
                        });
                      },
                      animatedTexts: [
                        TyperAnimatedText('ሰሌዳ ታይፒንግ',
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 300),
                            textStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            )),
                      ],
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
                            'ሰሌዳ ታይፒንግ የመጀመሪያው የአማረኛ ፅሁፍ መለማመጃ የሞባይል መተግበሪያ ነው።',
                            speed: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            textAlign: TextAlign.left,
                            textStyle: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
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
                            speed: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            textAlign: TextAlign.left,
                            textStyle: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Visibility(
                      visible: startNextNextNext,
                      child: AnimatedTextKit(
                        onTap: () {},
                        onFinished: () {
                          setState(() {
                            startNextNextNext = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        displayFullTextOnTap: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'Melloss',
                            speed: const Duration(milliseconds: 200),
                            curve: Curves.bounceOut,
                            textAlign: TextAlign.end,
                            textStyle: const TextStyle(
                                fontSize: 10, color: Colors.white70),
                          ),
                        ],
                      ),
                    )
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
            width: 10,
            height: 2,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Positioned(
          bottom: 9,
          left: 40,
          child: Column(
            children: [
              Container(
                width: 20,
                height: 1,
                color: Colors.white.withOpacity(0.6),
              ),
              Container(
                width: 20,
                height: 4,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 20,
          child: Container(
            width: 8,
            height: 2,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 35,
          child: Container(
            width: 10,
            height: 2,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  _buildScoreResult() {
    return Column(
      children: [
        Obx(() => _buildText('ከፍተኛ ነጥብ',
            size: 22,
            color: scoreController.isHighScore.value
                ? primaryColor
                : inactiveColor)),
        const SizedBox(height: 10),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildText('ፍጥነት',
                  color: scoreController.isHighScore.value
                      ? primaryColor
                      : inactiveColor),
              _buildText('${scoreController.highScore.value} WMP',
                  color: scoreController.isHighScore.value
                      ? primaryColor
                      : inactiveColor),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Visibility(
              visible: scoreController.isPlayed.value,
              child: _buildText('ያገኙት ነጥብ', size: 22, color: primaryColor)),
        ),
        const SizedBox(height: 20),
        Obx(
          () => Visibility(
            visible: scoreController.isPlayed.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildText('ፍጥነት', color: primaryColor),
                _buildText('${scoreController.currentSpeed.value} WPM',
                    color: primaryColor),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Visibility(
            visible: scoreController.isPlayed.value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildText('ትክክለኛነት', color: primaryColor),
                _buildText(
                    '${scoreController.currentAccuracy.value < 0 ? 0 : scoreController.currentAccuracy.value}%',
                    color: primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildText(String text,
      {Color color = Colors.white,
      double size = 18,
      FontWeight weight = FontWeight.w300}) {
    return Text(text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: 'roboto',
          fontWeight: weight,
        ));
  }

  _buildPlayButton() {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 80,
      height: 35,
      decoration: BoxDecoration(
        color: isDisabled ? inactiveColor : primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
        onPressed: isDisabled
            ? null
            : () {
                if (isActive[0] == true ||
                    isActive[0] == true ||
                    isActive[0] == true) {
                  if (isActive[0] == true) {
                    databaseController.selectedText.value =
                        databaseController.texts[randomNumber]['fidel'];
                  }
                  if (isActive[0] == true && isActive[1] == true) {
                    databaseController.selectedText.value =
                        databaseController.texts[randomNumber]['kutir'];
                  }
                  if (isActive[0] == true && isActive[2] == true ||
                      isActive[1] == true && isActive[2] == true) {
                    databaseController.selectedText.value =
                        databaseController.texts[randomNumber]['sirateNetib'];
                  }
                }
                if (isActive[3] == true) {
                  selectedTime = 10;
                } else if (isActive[4] == true) {
                  selectedTime = 60;
                } else if (isActive[5] == true) {
                  selectedTime = 120;
                } else {
                  selectedTime = 0;
                }

                Get.to(
                  () => Home(
                    currentText: databaseController.selectedText.value,
                    selectedTime: selectedTime,
                  ),
                );
              },
        child: _buildText('ጀምር', size: 15),
      ),
    );
  }

  @override
  void dispose() {
    scoreController.dispose();
    databaseController.dispose();
    super.dispose();
  }

  _buildAccountButton() {
    return Obx(
      () => IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openEndDrawer();
          },
          icon: scoreController.isAccountCreated.value
              ? const Icon(Icons.account_circle, size: 30)
              : SizedBox(
                  width: 50,
                  child: Stack(children: [
                    const Icon(Icons.account_circle, size: 30),
                    Positioned(
                      bottom: 0,
                      left: 23,
                      child: Icon(Icons.add, size: 10, color: primaryColor),
                    ),
                  ]),
                )),
    );
  }
}
