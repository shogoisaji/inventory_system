import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  String? mailAddress;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('sign in')),
      body: Center(
        child: Column(children: [
          Container(
            child: Text(
              '在庫管理システム',
              style: TextStyle(fontSize: 24),
            ),
            padding: EdgeInsets.all(20.0),
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
              isPassword: true),
          ElevatedButton(
            onPressed: () async {
              try {
                if (mailAddress != null && password != null) {
                  final service = AuthService();
                  await service.signIn(mailAddress!, password!);
                  // await service.signIn(mailAddress!, password!).catchError(
                  //   (e) {
                  //     debugPrint('サインインできませんでした $e');
                  //   },
                  // );
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
                      title: const Text("sigh inに失敗しました"),
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
            style:
                ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(100)),
            child: const Text(
              'sign in',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
          ),
          ElevatedButton(
            onPressed: () async {
              // サービスを呼び出す
              if (mailAddress != null && password != null) {
                final service = AuthService();
                await service.signUp(mailAddress!, password!).catchError(
                  (e) {
                    debugPrint('サインアップできませんでした $e');
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
            },
            style:
                ElevatedButton.styleFrom(fixedSize: const Size.fromWidth(100)),
            child: const Text(
              'sign up',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
