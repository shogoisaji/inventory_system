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
                mailAddress = newText;
              },
              isPassword: true),
          ElevatedButton(
            onPressed: () async {
              // サービスを呼び出す
              final service = AuthService();
              await service.signIn().catchError(
                (e) {
                  debugPrint('サインインできませんでした $e');
                },
              );
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
              final service = AuthService();
              await service.signUp().catchError(
                (e) {
                  debugPrint('サインアップできませんでした $e');
                },
              );
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
