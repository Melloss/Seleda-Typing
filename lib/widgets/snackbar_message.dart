import 'dart:async';
import 'package:flutter/material.dart';
import '../helper/color_pallet.dart';

class SnackBarMessage extends StatefulWidget {
  final String message;
  final bool isError;
  const SnackBarMessage(
      {super.key, required this.message, required this.isError});

  @override
  State<SnackBarMessage> createState() => _SnackBarMessageState();
}

class _SnackBarMessageState extends State<SnackBarMessage> with ColorPallet {
  double snackbarWidth = 300;
  bool showSnackBar = true;
  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      if (snackbarWidth == 0) {
        timer.cancel();
        if (mounted) {
          setState(() {
            showSnackBar = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            snackbarWidth = snackbarWidth - 50;
          });
        }
      }

      print(snackbarWidth);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showSnackBar,
      child: Container(
        width: 300,
        height: 50,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          color: foregroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Center(
              child: Text(
                widget.message,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ),
            Expanded(child: Container()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: snackbarWidth,
              height: 5,
              color: widget.isError ? errorColor : primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
