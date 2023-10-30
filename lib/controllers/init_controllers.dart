import 'package:get/get.dart';
import './score_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => ScoreController());
}
