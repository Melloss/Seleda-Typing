import 'package:flutter/material.dart';
import './helper/color_pallet.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'controller/score_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ColorPallet {
  final textController = TextEditingController();
  final scoreController = Get.put(ScoreController());
  String currentText =
      "Selam new Melloss Endet Nek hiwot endet nat Menor min yimesilal ee?";
  int index = -1;
  List<bool> isCorrect = [];
  var timer = null;
  int second = 0;
  int wpm = 0;
  int accuracy = 0;
  int numberOfError = 0;
  late FocusNode _focusNode;
  bool isFinished = false;

  void setTimer() {
    setState(() {
      isFinished = false;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (isFinished == true) {
        t.cancel();
      } else {
        setState(() {
          second++;
        });
      }
    });
  }

  void calculateWPMAndAccuracy() {
    setState(() {
      isFinished = true;
    });
    int numberOfWord = currentText.split(' ').length;
    if (second > 0) {
      wpm = (numberOfWord / (second / 60)).round();
    } else {
      wpm = (numberOfWord / 1).round();
    }
    accuracy =
        ((100 * (currentText.length - numberOfError)) / currentText.length)
            .round();
    scoreController.currentAccuracy.value = accuracy;
    scoreController.currentSpeed.value = wpm;
    textController.text = "";
    isCorrect = currentText.split('').map((value) => true).toList();
    setState(() {
      second = 0;
      isCorrect = isCorrect;
      index = -1;
      numberOfError = 0;
    });
    if (scoreController.currentSpeed.value > scoreController.highScore.value) {
      scoreController.highScore.value = scoreController.currentSpeed.value;
      scoreController.isHighScore.value = true;
    }
    scoreController.isPlayed.value = true;
    Get.back();
  }

  @override
  void initState() {
    isCorrect = currentText.split('').map((value) => true).toList();
    _focusNode = FocusNode();
    //scoreController.isPlayed.value = false;
    super.initState();
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void textOnchangeHandler(String text) {
    scoreController.isPlayed.value = false;
    scoreController.isHighScore.value = false;
    int currentIndex = text.length - 1;
    if (text.length <= currentText.length) {
      if (text.isNotEmpty) {
        if (text.length == 1) {
          setTimer();
        }
        if (text[currentIndex] == currentText[currentIndex]) {
          isCorrect[currentIndex] = true;
          setState(() {
            isCorrect = isCorrect;
          });
        } else {
          isCorrect[currentIndex] = false;
          setState(() {
            numberOfError++;
            isCorrect = isCorrect;
          });
        }

        setState(() {
          index = text.length - 1;
        });
        if (text.length == currentText.length) {
          calculateWPMAndAccuracy();
        }
      } else {
        print("empty");
        isCorrect = currentText.split('').map((value) => true).toList();
        setState(() {
          second = 0;
          isCorrect = isCorrect;
          index = -1;
          numberOfError = 0;
          isFinished = true;
        });
      }
    }
  }

  void openKeyboard() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, size: 15, color: inactiveColor),
        ),
      ),
      body: GestureDetector(
        onTap: openKeyboard,
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildText(),
              const SizedBox(height: 30),
              _buildTextField(),
              const SizedBox(height: 30),
              Text(second.toString()),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextField() {
    return Visibility.maintain(
      visible: false,
      child: TextField(
        mouseCursor: SystemMouseCursors.basic,
        focusNode: _focusNode,
        autofocus: true,
        controller: textController,
        onChanged: textOnchangeHandler,
        textInputAction: TextInputAction.none,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  _buildText() {
    return RichText(
      textScaleFactor: 2,
      textAlign: TextAlign.center,
      text: TextSpan(
        mouseCursor: MouseCursor.uncontrolled,
        children: [
          for (int i = 0; i < currentText.length; i++)
            TextSpan(
                style: TextStyle(
                    fontWeight:
                        i == index ? FontWeight.w500 : FontWeight.normal,
                    color: i == index
                        ? isCorrect[i]
                            ? correctColor
                            : errorColor
                        : i > index
                            ? inactiveColor
                            : isCorrect[i]
                                ? correctColor
                                : errorColor),
                text: currentText[i]),
        ],
      ),
    );
  }
}
