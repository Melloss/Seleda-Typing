import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreController extends GetxController {
  late SharedPreferences prefs;
  RxInt highScore = 0.obs;
  RxInt currentAccuracy = 0.obs;
  RxInt currentSpeed = 0.obs;
  RxBool isPlayed = false.obs;
  RxBool isHighScore = false.obs;
  RxBool isAccountCreated = false.obs;

  initSettings() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('highScore') == false) {
      prefs.setInt('highScore', 0);
      highScore.value = prefs.getInt('highScore')!;
    } else {
      highScore.value = prefs.getInt('highScore')!;
    }
    if (prefs.containsKey('isAccountCreated') == false) {
      prefs.setBool('isAccountCreated', false);
      isAccountCreated.value = prefs.getBool('isAccountCreated')!;
    } else {
      isAccountCreated.value = prefs.getBool('isAccountCreated')!;
    }
  }
}
