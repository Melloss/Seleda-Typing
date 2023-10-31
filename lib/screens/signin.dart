import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '../helper/color_pallet.dart';

class SignInLogIN extends StatefulWidget {
  const SignInLogIN({super.key});

  @override
  State<SignInLogIN> createState() => _SignInLogINState();
}

class _SignInLogINState extends State<SignInLogIN> with ColorPallet {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xFF252829),
                    borderRadius: BorderRadius.circular(5)),
                width: 500,
                height: 50,
                child: TextField(
                  style: Theme.of(context).textTheme.displayMedium,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: inactiveColor),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  color: const Color(0xFF252829),
                  borderRadius: BorderRadius.circular(5)),
              width: 500,
              height: 50,
              child: TextField(
                obscureText: !showPassword,
                style: Theme.of(context).textTheme.displayMedium,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: inactiveColor),
                    border: InputBorder.none,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword == false
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                        size: 20,
                        color: inactiveColor,
                      ),
                    )),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(top: 15),
              width: 500,
              height: 50,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            )
          ]),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: AnimatedTextKit(
              displayFullTextOnTap: true,
              totalRepeatCount: 1,
              animatedTexts: [
                RotateAnimatedText('ሰሌዳ',
                    textStyle: Theme.of(context).textTheme.displayLarge),
                RotateAnimatedText('የአማርኛ ፅሁፍ',
                    textStyle: Theme.of(context).textTheme.displayLarge),
                RotateAnimatedText('መለማመጃ ዌብሳይት',
                    textStyle: Theme.of(context).textTheme.displayLarge),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ],
      ),
    );
  }
}
