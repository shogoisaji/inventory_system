import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 通信の流れをまとめておくサービスクラス
class AuthService {
  /// サインイン
  Future<void> signIn(String _email, String _password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email, password: _password);
  }

  /// サインアウト
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// サインアップ
  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'mailAddress@gmail.com',
        password: 'password',
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
