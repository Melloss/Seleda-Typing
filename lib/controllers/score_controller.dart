import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreController extends GetxController {
  RxInt highScore = 0.obs;
  RxInt currentAccuracy = 0.obs;
  RxInt currentSpeed = 0.obs;
  RxBool isPlayed = false.obs;
  RxBool isHighScore = false.obs;

  int top1 = 0;
  int top2 = 0;
  int top3 = 0;
  int top4 = 0;
  int top5 = 0;

  initSettings() async {
    final scoreBox = await Hive.openBox('score');
    if (scoreBox.containsKey('highScore') == false) {
      scoreBox.put('highScore', 0);
    } else {
      highScore.value = scoreBox.get('highScore');
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
    print(top1);
    print(top2);
  }
}
