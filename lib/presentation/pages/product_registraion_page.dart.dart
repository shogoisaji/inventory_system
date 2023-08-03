import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/infrastructure/firebase/firebase_service.dart';
import 'package:go_router/go_router.dart';
import '../../application/state/state.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/dropdown_category.dart';
import '../wedget/text_style.dart';
import '../wedget/date_get.dart';
import 'package:path/path.dart';
import 'dart:io';

class ProductRegistrationPage extends ConsumerWidget {
  final TextEditingController productName = TextEditingController();
  final TextEditingController productVolume = TextEditingController();
  String currentDate = getCurrentDate();
  final String productUrl = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userNameProvider) ?? "";
    File? imageFile = ref.watch(imageFileProvider);
    final String fileName = ref.watch(imageFileProvider) != null
        ? basename((ref.watch(imageFileProvider))!.path)
        : "";

    return Scaffold(
        body: ListView(children: [
      Column(children: [
        Stack(children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: 350,
              color: const Color.fromARGB(255, 237, 155, 255),
            ),
          ),
          Positioned(
            left: 50,
            top: 10,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Data Arranging_Isometric.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 320,
              right: 0,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(130, 0, 0, 0),
                      offset: Offset(0, 0),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              )),
          Positioned(
            left: 15,
            top: 10,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleText(
                text: 'Product',
                color: Colors.white,
                size: 46,
              ),
              TitleText(
                text: 'Registration',
                color: Colors.white,
                size: 46,
              ),
            ]),
          ),
        ]),
        Center(
          child: Column(children: [
            SizedBox(
              width: 330,
              child: TextField(
                controller: productName,
                decoration: const InputDecoration(
                  labelText: '商品名',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Text(
                    '種類',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const DropdownCategory(),
              ],
            ),
            SizedBox(
              // padding: const EdgeInsets.only(top: 20),
              width: 330,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: productVolume,
                decoration: const InputDecoration(
                  labelText: '入庫数量',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.black12),
              width: 300,
              child: Row(
                children: [
                  Container(
                    child: Text(fileName ?? ""),
                  ),
                  IconButton(
                      icon: const Icon(Icons.folder_open_outlined),
                      onPressed: () async {
                        FirebaseService service = FirebaseService();
                        // imageFile = await service.pickImage();
                        ref.read(imageFileProvider.notifier).state =
                            await service.pickImage();
                      }),
                  IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButtonGradation(
                text: '商品登録',
                mainColor1: Color.fromARGB(255, 126, 191, 219),
                mainColor2: Color.fromARGB(255, 36, 68, 156),
                borderColor1: Color.fromARGB(255, 156, 206, 225),
                borderColor2: Color.fromARGB(255, 15, 5, 84),
                onPressed: () async {
                  if (productName.text != "") {
                    final service = FirebaseService();
                    final int volume = productVolume.text != ""
                        ? int.parse(productVolume.text)
                        : 0;
                    await service.upLoad(productName.text, selectedType, volume,
                        username, imageFile, fileName);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 255, 225, 225),
                          title: const Text("商品名は入力してください"),
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
                width: 100,
                height: 35,
                textSize: 16,
                textColor: Colors.white),
            const SizedBox(
              height: 30,
            ),
            CustomButtonGradation(
                text: '在庫一覧',
                mainColor1: Color.fromARGB(255, 94, 208, 161),
                mainColor2: Color.fromARGB(255, 6, 100, 85),
                borderColor1: Color.fromARGB(255, 222, 255, 195),
                borderColor2: Color.fromARGB(255, 0, 100, 57),
                onPressed: () {
                  context.go('/stock');
                },
                width: 100,
                height: 35,
                textSize: 16,
                textColor: Colors.white),
          ]),
        )
      ])
    ]));
  }
}
