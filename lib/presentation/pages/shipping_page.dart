import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';


class ShippingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('出庫'), actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {
                        return context.go('/account');
                      }),
                  Text(username)
                ])),
          )
        ]),
      body: Center(
        child: Column(
          children: [
            
            ElevatedButton(
              onPressed: () {
                return context.go('/stock');
              },
              child: const Text('back'),
            ),
          ],)
      ),
    );
  }
}