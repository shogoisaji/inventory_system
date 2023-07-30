import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/infrastructure/firebase/firestore_service.dart';
import 'package:go_router/go_router.dart';
import '../../application/state/state.dart';
import '../wedget/dropdown_category.dart';
import '../wedget/dropdown_category.dart';
import '../wedget/text_style.dart';
import '../wedget/custom_bottun.dart';
import '../wedget/date_get.dart';

class WarehousingPage extends ConsumerWidget {
  final TextEditingController productName = TextEditingController();
  final TextEditingController productId = TextEditingController();
  final TextEditingController productVolume = TextEditingController();
  String currentDate = getCurrentDate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: BoldText(size: 26, text: '入庫', color: Colors.white),
            actions: [
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
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10.0),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: 400,
              child: TextField(
                controller: productName,
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
              width: 400,
              child: TextField(
                controller: productId,
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              '種類',
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DropdownCategory(),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      print("icon pushed");
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: 400,
              child: TextField(
                controller: productVolume,
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
            const SizedBox(
              height: 20,
            ),
            Text('日付'),
            Container(
              child: Text(
                currentDate,
              ),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 30.0),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '入庫者',
            ),
            Container(
              child: Text(username),
              // padding: EdgeInsets.fromLTRB(200.0, 0.0, 200.0, 80.0),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onPressed: () async {
                if (productName != null &&
                    productId != null &&
                    productVolume != null) {
                  final service = FireStoreService();
                  await service.upLoad(productName.text, productId.text,
                      selectedType, productVolume.text);
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
