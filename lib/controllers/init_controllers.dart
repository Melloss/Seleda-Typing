import 'package:get/get.dart';
import './database_controller.dart';
import './score_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => ScoreController());
  Get.lazyPut(() => DatabaseController());
}
