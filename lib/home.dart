import 'package:flutter/material.dart';
import './helper/color_pallet.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ColorPallet {
  final textController = TextEditingController();
  String currentText =
      "Selam new Melloss Endet Nek hiwot endet nat Menor min yimesilal ee?";
  int index = -1;
  List<bool> isCorrect = [];
  late Timer timer;
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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Result")),
            content: Text(
                "Speed: $wpm WPM\nAccuracy: ${accuracy < 0 ? 0 : accuracy}%",
                textScaleFactor: 1.3),
            actions: [
              TextButton(
                onPressed: () {
                  textController.text = "";
                  Navigator.of(context).pop();
                  isCorrect =
                      currentText.split('').map((value) => true).toList();
                  setState(() {
                    second = 0;
                    isCorrect = isCorrect;
                    index = -1;
                    numberOfError = 0;
                  });
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  void initState() {
    isCorrect = currentText.split('').map((value) => true).toList();
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void textOnchangeHandler(String text) {
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
          print("Error: $numberOfError");
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
