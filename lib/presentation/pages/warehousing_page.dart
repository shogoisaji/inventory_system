import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/state/state.dart';
import '../../infrastructure/firebase/auth_service.dart';
import '../../infrastructure/firebase/testDB.dart';
import '../theme/text_style.dart';
import '../wedget/custom_bottun.dart';
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
        appBar: AppBar(
        centerTitle: true,
        title: BoldText(size:26, text:'入庫', color:Colors.white),
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
        body: Center(
          child: Column(children: [
            Container(
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: 500,
              child: TextField(
                controller: productController,
                decoration: const InputDecoration(
                  hintText: '商品名',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: 500,
              child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: '商品ID',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('カテゴリー',),
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
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: 500,
              child: TextField(
                controller: valueController,
                decoration: const InputDecoration(
                  hintText: '数量',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text('日付'),
            Container(
              child: Text(currentDate,),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            SizedBox(height: 20,),
            Text('入庫者',),
            Container(
              child: Text(username),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 80.0),
            ),
            SizedBox(height: 20,),
            CustomButton(
              onPressed: () {
                debugPrint('登録完了');
              },
              text: '入庫登録',
              mainColor: const Color.fromARGB(255, 255, 166, 158),
              shadowColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
              width: 130,
              height: 40,
              textSize: 20,
            ),
          ]),
        ));
  }
}
