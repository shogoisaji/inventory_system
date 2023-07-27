import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_various/presentation/theme/text_style.dart';

import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/custom_bottun.dart';
import '../wedget/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  String? mailAddress;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(
          text: 'ログイン',
          size: 26,
          color: Colors.white
        )
      ),
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: BoldText(
              text: '在庫管理システム',
              size: 26,
              color: Colors.black,
            ),
          ),
          CustomTextField(
              label: "メールアドレス",
              onChangefunc: (newText) {
                mailAddress = newText;
              },
              isPassword: false),
          CustomTextField(
            label: "パスワード",
            onChangefunc: (newText) {
              password = newText;
            },
            isPassword: true
          ),
          const SizedBox(height: 10.0,),
          CustomButton(text: 'ログイン',
            mainColor: Color.fromARGB(255, 174, 217, 224),
            shadowColor: Color.fromARGB(255, 45, 45, 45).withOpacity(0.2),
            width: 150,
            height: 50,
            textSize: 20,
            onPressed:() async {
              try {
                if (mailAddress != null && password != null) {
                  final service = AuthService();
                  await service.signIn(mailAddress!, password!);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("空欄があります"),
                        content: const Text("すべて記入してください"),
                        actions: [
                          TextButton(
                            child: const Text("OK"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                }
              } on FirebaseAuthException catch (e) {
                debugPrint("signerror");
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("ログインに失敗しました"),
                      content: const Text("ログイン情報を確認してください"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          ),
          const SizedBox(height: 20.0,),
          CustomButton(text: 'ユーザー登録',
            mainColor: const Color.fromARGB(255, 255, 166, 158),
            shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            width: 150,
            height: 50,
            textSize: 20,
            onPressed:() async {
              if (mailAddress != null && password != null) {
                final service = AuthService();
                await service.signUp(mailAddress!, password!).catchError(
                  (e) {
                    debugPrint('ユーザー登録できませんでした $e');
                  },
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("空欄があります"),
                      content: const Text("すべて記入してください"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          ),
          const SizedBox(height: 100,),
          ElevatedButton(
            onPressed: () async {
              try {
                final service = AuthService();
                await service.signIn('sample@gmail.com', 'password');
              } on FirebaseAuthException catch (e) {
                debugPrint("signerror");
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("ログインに失敗しました"),
                      content: const Text("ログイン情報を確認してください"),
                      actions: [
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 50), primary: Color.fromARGB(155, 255, 237, 187),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10) //こちらを適用
                )
            ),
            child: const Text(
              'Sample Account',
              style: TextStyle(fontSize: 20, color: Color.fromARGB(108, 0, 0, 0)),
            ),
          ),
        ]),
      ),
    );
  }
}
