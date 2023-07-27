import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/theme/text_style.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../wedget/line_inner.dart';

class StockPage extends ConsumerWidget {
  StockPage({Key? key}) : super(key: key);

  final ScrollController _homeController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(size:26, text:'在庫一覧', color:Colors.white),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    return context.go('/account');
                  }
                ),
                Text(username)
                ]
              )
            ),
          )
        ]
      ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            return context.go('/warehousing');
          },
          backgroundColor: const Color.fromARGB(255, 103, 103, 103),
          elevation: 5.0,
          label: BoldText(
            text: '入庫',
            size: 24,
            color: Colors.white,
            ), 
          icon: Icon(Icons.add), 
        ),
      body: ListView.separated(
        controller: _homeController,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            child: ListInner(indexNumber: (index + 1)),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Color.fromARGB(0, 255, 255, 255),
          thickness: 0,
        ),
        itemCount: 30
      ),
    );
  }
}
