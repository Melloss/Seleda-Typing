import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleda_typing/helper/snackbar.dart';
import '../screens/sign_up.dart';
import '../helper/color_pallet.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with ColorPallet {
  bool showPassword = false;
  final emailConroller = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildEmailTextField(),
            _buildPasswordTextField(),
            _buildLoginButton(),
            const SizedBox(height: 20),
            InkWell(
                onTap: () {
                  Get.to(() => const SignUp(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(seconds: 1));
                },
                child: Text(
                  'Don\'t you have an Account ?',
                  style: Theme.of(context).textTheme.displayMedium,
                ))
          ]),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: AnimatedTextKit(
              displayFullTextOnTap: true,
              totalRepeatCount: 1,
              animatedTexts: [
                RotateAnimatedText('ሰሌዳ ታይፒንግ',
                    duration: const Duration(seconds: 2),
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

  _buildEmailTextField() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: foregroundColor, borderRadius: BorderRadius.circular(5)),
        width: 500,
        height: 50,
        child: TextField(
          controller: emailConroller,
          style: Theme.of(context).textTheme.displayMedium,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 17,
                  color: inactiveColor,
                ),
            prefixIcon: Icon(Icons.person, color: inactiveColor),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _buildPasswordTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: foregroundColor, borderRadius: BorderRadius.circular(5)),
      width: 500,
      height: 50,
      child: TextField(
        controller: passwordController,
        obscureText: !showPassword,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 17,
                  color: inactiveColor,
                ),
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
    );
  }

  _buildLoginButton() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 15),
      width: 500,
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          //TODO:
          snackbar(context, 'Selam', false);
        },
        child: Center(
          child: Text(
            'Login',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
