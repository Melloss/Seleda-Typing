import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:seleda_typing/screens/starter_page.dart';
import 'package:seleda_typing/services/authentication.dart';
import '../controllers/score_controller.dart';
import '../helper/color_pallet.dart';
import '../helper/snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>
    with ColorPallet, TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final userNameController = TextEditingController();
  bool isUserNameFree = false;
  String userNameMessage = '';
  ScoreController scoreController = Get.find();
  bool isLoading = false;

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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('user-names').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            if (mounted) {
              scoreController.isUserNameLoading.value = true;
            }
          } else {
            if (mounted) {
              scoreController.isUserNameLoading.value = false;
            }
          }
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: foregroundColor, borderRadius: BorderRadius.circular(5)),
            width: 500,
            height: 50,
            child: TextField(
              onChanged: (userName) {
                if (userName.length >= 5) {
                  final documents = snapshot.data!.docs;
                  bool isUserNameExist = false;
                  for (var element in documents) {
                    if (element.data()['userName'] == userName) {
                      isUserNameExist = true;
                      break;
                    } else {
                      isUserNameExist = false;
                    }
                  }
                  if (isUserNameExist == true) {
                    isUserNameFree = false;

                    setState(() {
                      userNameMessage = 'ተይዟል';
                    });
                  } else {
                    isUserNameFree = true;
                    setState(() {
                      userNameMessage = 'አልተያዘም';
                    });
                  }

                  print(isUserNameFree);
                  print(userName);
                }
              },
              controller: userNameController,
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration(
                hintText: 'User Name',
                hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 17,
                      color: inactiveColor,
                    ),
                suffixIcon: userNameMessage.isEmpty
                    ? Obx(() => Visibility(
                          visible: scoreController.isUserNameLoading.value,
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 15.0,
                              controller: AnimationController(
                                  vsync: this,
                                  duration: const Duration(milliseconds: 1200)),
                            ),
                          ),
                        ))
                    : SizedBox(
                        width: 100,
                        height: 30,
                        child: Center(
                          child: Text(
                            userNameMessage,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: userNameMessage == 'አልተያዘም'
                                      ? primaryColor
                                      : errorColor,
                                ),
                          ),
                        ),
                      ),
                prefixIcon: Icon(Icons.person, color: inactiveColor),
                border: InputBorder.none,
              ),
            ),
          );
        });
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
        onTap: () async {
          String email = emailController.text;
          String userName = userNameController.text;
          String password1 = passwordController1.text;
          String password2 = passwordController2.text;
          bool isEmailValid = false;
          bool isUserNameValid = false;
          bool isPassowordValid = false;
          if (userName.isEmpty ||
              email.isEmpty ||
              password1.isEmpty ||
              password2.isEmpty) {
            snackbar(context, 'UserName, Email or Password Empty', true);
          } else {
            if (userName.length < 5) {
              snackbar(context, 'Username is less than 5 character', true);
            } else {
              isUserNameValid = true;
            }
            if (!email.isEmail) {
              snackbar(context, 'Email is Invalid', true);
            } else {
              isEmailValid = true;
            }
            if (isUserNameFree == false) {
              snackbar(context, 'user name is occupied', true);
            }
            if (password1 != password2) {
              snackbar(context, 'Passowords are not the same', true);
            } else {
              if (password1.length < 6) {
                snackbar(context, 'Password is less than 6 characters', true);
              } else {
                isPassowordValid = true;
              }
            }
          }
          if (isPassowordValid == true &&
              isEmailValid == true &&
              isUserNameValid == true &&
              isUserNameFree == true) {
            setState(() {
              isLoading = true;
            });
            await Authentication.signupWithEmailAndPassword(
                context, email, password1, userName);
            setState(() {
              isLoading = false;
            });
            Get.offAll(() => const StarterPage());
          }
        },
        child: Center(
          child: isLoading == true
              ? SpinKitThreeBounce(
                  color: Colors.white,
                  size: 15.0,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200)),
                )
              : Text(
                  'Register',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
        ),
      ),
    );
  }
}
