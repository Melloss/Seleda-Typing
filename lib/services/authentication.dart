import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:seleda_typing/controllers/score_controller.dart';
import 'package:seleda_typing/helper/snackbar.dart';

class Authentication {
  static signupWithEmailAndPassword(BuildContext context, String email,
      String password, String userName) async {
    try {
      final authentication = FirebaseAuth.instance;
      final store = FirebaseFirestore.instance;
      final scoreBox = await Hive.openBox('score');
      ScoreController scoreController = Get.find();
      UserCredential user = await authentication.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user?.updateDisplayName(userName);
      String uid = user.user!.uid;
      await store.collection('user-names').doc(uid).set({
        'userName': userName,
      });
      scoreBox.put(
        'userName',
        userName,
      );
      scoreBox.put('isLoggedBefore', true);
      scoreController.userName = userName;
      scoreBox.close();
      return uid;
    } catch (error) {
      print(error);
      snackbar(context, error.toString(), true);
    }
    return '';
  }

  static signinWithEmailAndPassword(String email, String password) async {
    try {
      //
      final authentication = FirebaseAuth.instance;
      ScoreController scoreController = Get.find();
      UserCredential user = await authentication.signInWithEmailAndPassword(
          email: email, password: password);
      String userName = user.user!.displayName!;
      final scoreBox = await Hive.openBox('score');
      scoreBox.put(
        'userName',
        userName,
      );
      scoreBox.put('isLoggedBefore', true);
      scoreController.userName = userName;
      scoreBox.close();
      return user.user!.uid;
    } catch (error) {
      print(error);
    }
    return '';
  }

  static signout() async {
    final authentication = FirebaseAuth.instance;
    await authentication.signOut();
  }
}
