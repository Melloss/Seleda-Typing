import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/color_pallet.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with ColorPallet {
  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: inactiveColor,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            _buildUsernameTextField(),
            _buildEmailTextField(),
            _buildPasswordTextField(passwordController1, 'Password'),
            _buildPasswordTextField(passwordController2, 'Password Again'),
            _buildRegisterButton(),
          ],
        ));
  }

  _buildPasswordTextField(TextEditingController controller, String hintText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: foregroundColor, borderRadius: BorderRadius.circular(5)),
      width: 500,
      height: 50,
      child: TextField(
          controller: controller,
          obscureText: true,
          style: Theme.of(context).textTheme.displayMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 17,
                  color: inactiveColor,
                ),
            prefixIcon: Icon(Icons.lock, color: inactiveColor),
            border: InputBorder.none,
          )),
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
          controller: emailController,
          style: Theme.of(context).textTheme.displayMedium,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 17,
                  color: inactiveColor,
                ),
            prefixIcon: Icon(Icons.email, color: inactiveColor),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  _buildUsernameTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: foregroundColor, borderRadius: BorderRadius.circular(5)),
      width: 500,
      height: 50,
      child: TextField(
        controller: userNameController,
        style: Theme.of(context).textTheme.displayMedium,
        decoration: InputDecoration(
          hintText: 'User Name',
          hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 17,
                color: inactiveColor,
              ),
          prefixIcon: Icon(Icons.person, color: inactiveColor),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _buildRegisterButton() {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(top: 35),
      width: 500,
      height: 45,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          //TODO:
        },
        child: Center(
          child: Text(
            'Register',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}
