import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreController extends GetxController {
  RxInt highScore = 0.obs;
  RxInt currentAccuracy = 0.obs;
  RxInt currentSpeed = 0.obs;
  RxBool isPlayed = false.obs;
  RxBool isHighScore = false.obs;
  String userName = '';
  RxBool isUserNameLoading = false.obs;
  bool isLoggedBefore = false;

  int top1 = 0;
  int top2 = 0;
  int top3 = 0;
  int top4 = 0;
  int top5 = 0;
  int top6 = 0;
  int top7 = 0;

  initSettings() async {
    final scoreBox = await Hive.openBox('score');
    if (scoreBox.containsKey('highScore') == false) {
      scoreBox.put('highScore', 0);
    } else {
      highScore.value = scoreBox.get('highScore');
    }
    if (scoreBox.containsKey('userName') == false) {
      scoreBox.put('userName', '');
    } else {
      userName = scoreBox.get('userName');
    }
    if (scoreBox.containsKey('isLoggedBefore') == false) {
      scoreBox.put('isLoggedBefore', false);
    } else {
      isLoggedBefore = scoreBox.get('isLoggedBefore');
    }
    await scoreBox.close();
  }

  fetchTop5Scrore() {
    final store = FirebaseFirestore.instance;
    final stream = store.collection('high-score').snapshots();
    return stream;
  }

  getTop5Scores() async {
    final store = FirebaseFirestore.instance;
    final snap1 = await store.collection('high-score').doc('Top-1').get();
    top1 = snap1.data()!['speed'];
    final snap2 = await store.collection('high-score').doc('Top-2').get();
    top2 = snap2.data()!['speed'];
    final snap3 = await store.collection('high-score').doc('Top-3').get();
    top3 = snap3.data()!['speed'];
    final snap4 = await store.collection('high-score').doc('Top-4').get();
    top4 = snap4.data()!['speed'];
    final snap5 = await store.collection('high-score').doc('Top-5').get();
    top5 = snap5.data()!['speed'];
    final snap6 = await store.collection('high-score').doc('Top-6').get();
    top6 = snap6.data()!['speed'];
    final snap7 = await store.collection('high-score').doc('Top-7').get();
    top7 = snap7.data()!['speed'];
  }

  registerHighScore() async {
    try {
      final store = FirebaseFirestore.instance;
      if (currentSpeed.value > top1) {
        await store.collection('high-score').doc('Top-1').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top2) {
        await store.collection('high-score').doc('Top-2').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top3) {
        await store.collection('high-score').doc('Top-3').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top4) {
        await store.collection('high-score').doc('Top-4').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top5) {
        await store.collection('high-score').doc('Top-5').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top6) {
        await store.collection('high-score').doc('Top-6').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      } else if (currentSpeed.value > top7) {
        await store.collection('high-score').doc('Top-7').update({
          'userName': userName,
          'speed': currentSpeed.value,
          'accuracy': currentAccuracy.value,
        });
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
