import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../theme/text_style.dart';
import '../wedget/custom_bottun.dart';
import '../wedget/text_input.dart';


class AccountPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('アカウント'), actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {
                        // final service = AuthService();
                        // service.signOut();
                      }),
                  Text(username)
                ])),
          )
        ]),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            NormalText(size: 30, text: '名前 : $username',color: Colors.black),
            SizedBox(height: 50),
            NormalText(size: 30, text: 'Email : $email',color: Colors.black),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                return context.go('/stock');
              },
              child: const Text('在庫一覧'),
            ),
            SizedBox(height: 30), 
            ElevatedButton(
              onPressed: () {
                final service = AuthService();
                service.signOut();
              },
              child: const Text('log out'),
            ),
            SizedBox(height: 30), 
            CustomButton(text: 'ログアウト',
              onPressed: (){
                final service = AuthService();
                service.signOut();
              },
              width: 100,
              height: 50,
              mainColor: Colors.blue,
              shadowColor: Colors.blue,
            )
          ],
        )
      ),
    );
  }
}