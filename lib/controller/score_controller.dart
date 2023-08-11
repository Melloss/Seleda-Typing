import 'package:get/get.dart';

class ScoreController extends GetxController {
  RxInt highScore = 0.obs;
  RxInt currentAccuracy = 0.obs;
  RxInt currentSpeed = 0.obs;
  RxBool isPlayed = false.obs;
  RxBool isHighScore = false.obs;
}
