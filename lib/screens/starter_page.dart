import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../screens/sign_in.dart';
import '../services/authentication.dart';
import '../helper/color_pallet.dart';
import './home.dart';
import '../controllers/score_controller.dart';
import '../widgets/end_drawer.dart';
import '../helper/responsive.dart';
import '../widgets/blackboard.dart';

class StarterPage extends StatefulWidget {
  const StarterPage({super.key});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> with ColorPallet {
  List<bool> isActive = [true, false, false, false, false, false];

  bool isDisabled = false;
  int randomNumber = 0;
  int selectedTime = 10;
  ScoreController scoreController = Get.find();
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
          _buildUserName(),
          const BlackBoard(),
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      width: responsiveOptionPane(context),
      height: 45,
      decoration: BoxDecoration(
        color: optionBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTextButton(0, 'ፊደል'),
          _buildTextButton(1, 'ቁጥር'),
          _buildTextButton(2, 'ሥ-ነጥብ'),
          VerticalDivider(
            color: inactiveColor.withOpacity(0.5),
            width: 0.5,
          ),
          _buildTextButton(3, '፲'),
          _buildTextButton(4, '፩'),
          _buildTextButton(5, '፪'),
        ],
      ),
    );
  }

  _buildTextButton(int index, String text) {
    return SizedBox(
      width: 80,
      height: 45,
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
            style:
                const TextStyle(fontSize: 13, fontFamily: 'NotoSerifEthiopic'),
          ),
          index > 2 ? const SizedBox(height: 2) : const SizedBox.shrink(),
          Visibility(
            visible: index > 2,
            child: Text(
              index == 3 ? "ሰከንድ" : "ደቂቃ",
              style: const TextStyle(
                fontFamily: 'NotoSerifEthiopic',
                fontSize: 10,
              ),
            ),
          )
        ]),
      ),
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
              _buildText('${scoreController.highScore.value} WPM',
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
          fontFamily: 'NotoSerifEthiopic',
          color: color,
          fontSize: size,
          fontWeight: weight,
        ));
  }

  _buildPlayButton() {
    return Container(
      clipBehavior: Clip.antiAlias,
      width: 130,
      height: 50,
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
                    // databaseController.selectedText.value =
                    //     databaseController.texts[randomNumber]['fidel'];
                  }
                  if (isActive[0] == true && isActive[1] == true) {
                    // databaseController.selectedText.value =
                    //     databaseController.texts[randomNumber]['kutir'];
                  }
                  if (isActive[0] == true && isActive[2] == true ||
                      isActive[1] == true && isActive[2] == true) {
                    // databaseController.selectedText.value =
                    //     databaseController.texts[randomNumber]['sirateNetib'];
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
                    currentText: 'Selam',
                    selectedTime: selectedTime,
                  ),
                );
              },
        child: _buildText('ጀምር', size: 20),
      ),
    );
  }

  @override
  void dispose() {
    scoreController.dispose();
    super.dispose();
  }

  _buildAccountButton() {
    return Container();
  }

  _buildUserName() {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, bottom: 35),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Icon(
          Icons.person_2,
          size: 27,
          color: inactiveColor,
        ),
        const SizedBox(width: 10),
        Text(
          scoreController.userName,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: inactiveColor,
                fontSize: 18,
              ),
        ),
        const SizedBox(width: 20),
        Icon(
          Icons.notifications,
          size: 24,
          color: inactiveColor,
        ),
        const SizedBox(width: 10),
        InkWell(
            onTap: () async {
              final scoreBox = await Hive.openBox('score');
              scoreBox.put('userName', '');
              scoreBox.put('isLoggedBefore', false);
              scoreController.userName = '';
              scoreController.isLoggedBefore = false;
              scoreBox.close();
              Authentication.signout();
              Get.offAll(() => const SignIn());
            },
            child: Icon(
              Icons.logout,
              size: 22,
              color: inactiveColor,
            ))
      ]),
    );
  }
}
