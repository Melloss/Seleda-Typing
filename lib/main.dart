import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/starter_page.dart';
import './screens/sign_in.dart';
import './firebase_options.dart';
import './controllers/score_controller.dart';
import './helper/color_pallet.dart';
import './controllers/init_controllers.dart' as di;
import './helper/responsive.dart';

class App extends StatelessWidget with ColorPallet {
  App({super.key});
  ScoreController scoreController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          scoreController.isLoggedBefore ? const StarterPage() : const SignIn(),
      theme: _buildTheme(context),
    );
  }

  _buildTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: backgroundColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'NotoSerifEthiopic',
            color: Colors.white70,
            fontSize: responsiveFontSize(context, 26),
          ),
          displayMedium: TextStyle(
            fontFamily: 'NotoSerifEthiopic',
            color: Colors.white70,
            fontSize: responsiveFontSize(context, 20),
          ),
          displaySmall: TextStyle(
            fontFamily: 'NotoSerifEthiopic',
            color: Colors.white60,
            fontSize: responsiveFontSize(context, 15),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor:
              MaterialStatePropertyAll(inactiveColor.withOpacity(0.3)),
        )));
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  ScoreController scoreController = Get.find();
  await scoreController.initSettings();
  scoreController.dispose();

  runApp(App());
}
