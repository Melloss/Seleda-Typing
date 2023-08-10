import 'package:flutter/material.dart';
import './helper/color_pallet.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> with ColorPallet {
  List<bool> isActive = [true, false, true, false, false];
  bool startNext = false;
  bool startNextNext = false;
  bool startNextNextNext = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          _buildBlackBoard(),
          _buildOptionPane(),
        ],
      ),
    );
  }

  _buildOptionPane() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: optionBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTextButton(0, 'ፊደል'),
          _buildTextButton(1, 'ቁጥር'),
          Expanded(child: Container()),
          const VerticalDivider(),
          _buildTextButton(2, '፲'),
          _buildTextButton(3, '፳'),
          _buildTextButton(4, '፴'),
          Text('ደቂቃ', style: TextStyle(color: inactiveColor, fontSize: 10)),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  _buildTextButton(int index, String text) {
    return TextButton(
      onPressed: () {
        if (index > 1) {
          isActive[2] = false;
          isActive[3] = false;
          isActive[4] = false;
          setState(() {
            isActive[index] = true;
          });
        } else {
          setState(() {
            isActive[index] = !isActive[index];
          });
        }
      },
      style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(
              isActive[index] ? Colors.white : inactiveColor)),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }

  _buildBlackBoard() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.2),
                Colors.orange.withOpacity(0.28),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                blackBoardColor2.withOpacity(0.75),
                blackBoardColor1,
                blackBoardColor2.withOpacity(0.75),
              ],
            )),
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
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
                            textStyle: const TextStyle(fontSize: 10),
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
}
