import 'package:flutter/material.dart';
import './starter_page.dart';
import './helper/color_pallet.dart';

class App extends StatelessWidget with ColorPallet {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const StarterPage(),
      theme: ThemeData.dark().copyWith(
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20)),
        foregroundColor: MaterialStatePropertyAll(inactiveColor),
      ))),
    );
  }
}

main() {
  runApp(App());
}
