import 'package:flutter/material.dart';
import './starter_page.dart';
import './helper/color_pallet.dart';
import 'package:get/get.dart';

class App extends StatelessWidget with ColorPallet {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const StarterPage(),
      theme: ThemeData.dark().copyWith(
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
        padding:
            const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 5)),
        foregroundColor:
            MaterialStatePropertyAll(inactiveColor.withOpacity(0.3)),
      ))),
    );
  }
}

main() {
  runApp(App());
}
