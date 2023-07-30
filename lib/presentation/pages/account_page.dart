import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/text_style.dart';
import '../wedget/custom_bottun.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

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
                    icon: const Icon(Icons.account_circle), onPressed: () {}),
                Text(username)
              ])),
        )
      ]),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 50),
          NormalText(size: 30, text: '名前 : $username', color: Colors.black),
          const SizedBox(height: 50),
          NormalText(size: 30, text: 'Email : email', color: Colors.black),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              return context.go('/stock');
            },
            child: const Text('在庫一覧'),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {},
            child: const Text('log out'),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'ログアウト',
            onPressed: () {
              final service = AuthService();
              service.signOut();
            },
            width: 100,
            height: 50,
            mainColor: Colors.blue,
            shadowColor: Colors.blue,
          )
        ],
      )),
    );
  }
}
