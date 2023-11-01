import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:seleda_typing/helper/media_query.dart';
import 'package:get/get.dart';
import '../helper/color_pallet.dart';
import '../controllers/score_controller.dart';

class Home extends StatefulWidget {
  final String currentText;
  final int selectedTime;
  const Home(
      {super.key, required this.currentText, required this.selectedTime});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ColorPallet {
  final textController = TextEditingController();
  ScoreController scoreController = Get.find();
  int index = -1;
  List<bool> isCorrect = [];
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  int second = 0;
  int wpm = 0;
  int accuracy = 0;
  int numberOfError = 0;
  int prevIndex = -1;
  late FocusNode _focusNode;
  bool isFinished = false;
  bool isTimeIsUp = false;

  void setTimer() {
    if (mounted) {
      setState(() {
        isFinished = false;
      });
    }

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (widget.selectedTime > 0) {
        if (second - 1 == 0) {
          t.cancel();
          isTimeIsUp = true;
          calculateWPMAndAccuracy();
        }
      }
      if (isFinished == true) {
        t.cancel();
      } else {
        if (mounted) {
          setState(() {
            widget.selectedTime > 0 ? second-- : second++;
          });
        }
      }
    });
  }

  void calculateWPMAndAccuracy() async {
    if (isTimeIsUp == false) {
      if (mounted) {
        setState(() {
          isFinished = true;
        });
      }
    }

    int numberOfWord = 0;
    if (isTimeIsUp == true) {
      String temp = widget.currentText.substring(0, index + 1);
      numberOfWord = temp.split(' ').length;
      accuracy = ((100 * (temp.length - numberOfError)) / temp.length).round();
    } else {
      numberOfWord = widget.currentText.split(' ').length;
      accuracy = ((100 * (widget.currentText.length - numberOfError)) /
              widget.currentText.length)
          .round();
    }
    if (widget.selectedTime > 0) {
      if ((widget.selectedTime - second) > 0) {
        wpm = (numberOfWord / ((widget.selectedTime - second) / 60)).round();
      } else {
        wpm = (numberOfWord / 1).round();
      }
    } else {
      if (second > 0) {
        wpm = (numberOfWord / (second / 60)).round();
      } else {
        wpm = (numberOfWord / 1).round();
      }
    }

    scoreController.currentAccuracy.value = accuracy;
    scoreController.currentSpeed.value = wpm;
    scoreController.registerHighScore();

    if (scoreController.currentSpeed.value > scoreController.highScore.value &&
        scoreController.currentAccuracy.value > 70) {
      scoreController.highScore.value = scoreController.currentSpeed.value;
      //saving high score...
      final scoreBox = await Hive.openBox('score');
      scoreBox.put('highScore', scoreController.currentSpeed.value);
      scoreController.isHighScore.value = true;
      await scoreBox.close();
    }
    scoreController.isPlayed.value = true;

    Get.back();
  }

  @override
  void initState() {
    if (widget.selectedTime > 0) {
      if (mounted) {
        setState(() {
          second = widget.selectedTime;
        });
      }
    }
    isCorrect = widget.currentText.split('').map((value) => true).toList();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    timer = null;
    _focusNode.dispose();
    textController.dispose();
    scoreController.onClose();
    super.dispose();
  }

  void textOnchangeHandler(String text) {
    prevIndex = index;
    try {
      scoreController.isPlayed.value = false;
      scoreController.isHighScore.value = false;
      int currentIndex = text.length - 1;
      if (text.length <= widget.currentText.length) {
        if (text.isNotEmpty) {
          if (index == -1) {
            setTimer();
          }
          if (text[currentIndex] == widget.currentText[currentIndex]) {
            if (mounted) {
              setState(() {
                isCorrect[currentIndex] = true;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                isCorrect[currentIndex] = false;
              });
            }
          }
          if (mounted) {
            setState(() {
              index = text.length - 1;
            });
          }

          if (text.length == widget.currentText.length) {
            calculateWPMAndAccuracy();
          }
        } else {
          isCorrect =
              widget.currentText.split('').map((value) => true).toList();
          if (mounted) {
            setState(() {
              second = widget.selectedTime > 0 ? widget.selectedTime : 0;
              isCorrect = isCorrect;
              index = -1;
              numberOfError = 0;
              isFinished = true;
            });
          }
        }
      }
      if (prevIndex > -1) {
        if (isCorrect[prevIndex] == false) {
          if (mounted) {
            setState(() {
              numberOfError++;
              isCorrect[currentIndex] = false;
            });
          }
        }
      }
      print("noOfError: $numberOfError");
    } catch (e) {
      print(e);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: index == -1
              ? () {
                  timer ??= Timer.periodic(const Duration(seconds: 1), (t) {});
                  Get.back();
                }
              : null,
          icon: Icon(Icons.arrow_back_ios,
              size: 15, color: index > -1 ? inactiveColor : Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(_focusNode);
        },
        child: Container(
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTop(),
                  _buildText(),
                  const SizedBox(height: 30),
                  Expanded(child: _buildTextField()),
                ])),
      ),
    );
  }

  _buildTextField() {
    return Visibility.maintain(
      visible: false,
      child: TextField(
        autofocus: true,
        focusNode: _focusNode,
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
          for (int i = 0; i < widget.currentText.length; i++)
            TextSpan(
              style: TextStyle(
                  fontWeight: i == index ? FontWeight.w500 : FontWeight.normal,
                  color: i == index
                      ? index != prevIndex
                          //if it is for the first time
                          ? primaryColor
                          : isCorrect[i]
                              ? correctColor
                              : errorColor
                      : i > index
                          ? inactiveColor
                          : isCorrect[i]
                              ? correctColor
                              : errorColor),
              text: widget.currentText[i],
            ),
        ],
      ),
    );
  }

  _buildTop() {
    return Container(
        height: 40,
        width: screenWidth(context) * 0.35,
        margin: const EdgeInsets.only(bottom: 35),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor),
          color: optionBackground,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: index > -1
                  ? () {
                      textController.text = "";
                      isCorrect = widget.currentText
                          .split('')
                          .map((value) => true)
                          .toList();
                      if (mounted) {
                        setState(() {
                          second =
                              widget.selectedTime > 0 ? widget.selectedTime : 0;
                          isCorrect = isCorrect;
                          index = -1;
                          numberOfError = 0;
                          isFinished = true;
                        });
                      }
                    }
                  : null,
              icon: Icon(Icons.refresh,
                  size: 20,
                  color: index > -1
                      ? primaryColor.withOpacity(0.7)
                      : primaryColor.withOpacity(0.3)),
            ),
            const SizedBox(width: 15),
            VerticalDivider(
              color: backgroundColor,
            ),
            Expanded(
              child: Center(
                child: Text(
                  second.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    color: index > -1
                        ? primaryColor
                        : primaryColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            //Expanded(child: Container()),
          ],
        ));
  }
}
