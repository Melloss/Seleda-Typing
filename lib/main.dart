import 'package:flutter/material.dart';
import 'controllers/database_controller.dart';
import 'controllers/score_controller.dart';
import './starter_page.dart';
import './helper/color_pallet.dart';
import 'package:get/get.dart';
import 'controllers/init_controllers.dart' as di;

class App extends StatelessWidget with ColorPallet {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const StarterPage(),
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: backgroundColor,
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            foregroundColor:
                MaterialStatePropertyAll(inactiveColor.withOpacity(0.3)),
          ))),
    );
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  DatabaseController databaseController = Get.find();

  await databaseController.init();
  await databaseController.fetch();
  await databaseController.closeDb();
  databaseController.dispose();
  ScoreController scoreController = Get.find();
  await scoreController.initSettings();
  scoreController.dispose();

  runApp(App());
}
