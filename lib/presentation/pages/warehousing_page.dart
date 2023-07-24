import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../../infrastructure/firebase/testDB.dart';
import '../theme/button_sytle.dart';
import '../theme/text_style.dart';
import '../wedget/date_get.dart';
import '../wedget/dropdown_category.dart';

class WarehousingPage extends ConsumerWidget {
  final TextEditingController productController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  String currentDate = getCurrentDate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('入庫'), actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {
                        final service = AuthService();
                        service.signOut();
                      }),
                  Text(username)
                ])),
          )
        ]),
        body: Center(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Text(
              '商品名',
              style: titleStyle,
            ),
            Container(
              child: TextField(
                controller: productController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '商品名',
                ),
              ),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Text(
              '商品ID',
              style: titleStyle,
            ),
            Container(
              child: TextField(
                controller: idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '商品ID',
                ),
              ),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            Text(
              'カテゴリー',
              style: titleStyle,
            ),
            Container(
              child: Row(
                children: [
                  DropdownCategory(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      print("icon pushed");
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            Text(
              '数量',
              style: titleStyle,
            ),
            Container(
              child: TextField(
                controller: valueController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '数量',
                ),
              ),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            Text(
              '日付',
              style: titleStyle,
            ),
            Container(
              child: Text(currentDate, style: nomalStyle),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            Text(
              '入庫者',
              style: titleStyle,
            ),
            Container(
              child: Text("login_name", style: nomalStyle),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 80.0),
            ),
            CustomButton(
              onPressed: () {
                debugPrint('登録完了');
              },
              label: '入庫登録',
            ),
          ]),
        ));
  }
}
