import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_test_various/infrastructure/firebase/firebase_service.dart';
import 'package:go_router/go_router.dart';
import '../../application/state/state.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/dropdown_category.dart';
import '../wedget/text_style.dart';
import '../wedget/date_get.dart';
import 'dart:io';

class ProductRegistrationPage extends HookConsumerWidget {
  ProductRegistrationPage({super.key});
  String currentDate = getCurrentDate();
  final String productUrl = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productName = useTextEditingController();
    final productVolume = useTextEditingController();
    final username = ref.watch(userNameProvider) ?? "";
    File? imageFile = ref.watch(imageFileProvider);
    final String fileName = imageFile != null ? imageFile.path : "";
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      height: _screenSize.height,
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: _screenSize.height,
          ),
          height: 800,
          child: Stack(children: [
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 237, 155, 255),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 500,
                child: Stack(children: [
                  Positioned(
                    left: 50,
                    top: 100,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'images/Data Arranging_Isometric.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 60,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: 440,
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
                    child: Column(children: [
                      const SizedBox(
                        height: 15,
                      ),
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
                        width: 330,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                        width: 330,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 220,
                              child: Text(
                                fileName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.camera_alt_outlined),
                                onPressed: () async {
                                  FirebaseService service = FirebaseService();
                                  File? file =
                                      await service.pickImage("camera");
                                  if (file != null) {
                                    ref
                                        .read(imageFileProvider.notifier)
                                        .chageFile(file);
                                  }
                                }),
                            IconButton(
                                icon: const Icon(Icons.folder_open_outlined),
                                onPressed: () async {
                                  FirebaseService service = FirebaseService();
                                  File? file =
                                      await service.pickImage("gallery");
                                  if (file != null) {
                                    ref
                                        .read(imageFileProvider.notifier)
                                        .chageFile(file);
                                  }
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
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
                              await service.upLoad(
                                  productName.text,
                                  selectedType,
                                  volume,
                                  username,
                                  imageFile,
                                  fileName);
                              if (context.mounted) {
                                showDialog(
                                  useRootNavigator: false,
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  barrierDismissible: false,
                                );
                                Future.delayed(const Duration(seconds: 2), () {
                                  context.go('/stock');
                                });
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 225, 225),
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
                        height: 20,
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
                    ])),
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
