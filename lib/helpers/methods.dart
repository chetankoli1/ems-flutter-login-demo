import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../screens/homeScreen.dart';

// Future<AuthCredential> googleLogin() sync{

// }

void startLogin(GlobalKey<FormState> _loginKey,String email, String pass) async {
    if (_loginKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email:email,
                password: pass)
            .then(
              (value) => {
                Get.to(const HomeScreen()),
                Fluttertoast.showToast(msg: 'user abc'),
              },
            )
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: 'No user found for that email.');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
          print('Wrong password provided for that user.');
        }
      }
    }
  }
