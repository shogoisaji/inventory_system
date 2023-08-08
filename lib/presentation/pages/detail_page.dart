import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firebase_service.dart';
import '../dialogs/decrement_dialog.dart';
import '../dialogs/increment_dialog.dart';
import '../wedget/account_ditail_view.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/text_style.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key});

  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String pruductNumber = ref.watch(detailProductProvider).toString();
    final String docName = ref.watch(productDocumentProvider);
    final String username = ref.watch(userNameProvider) ?? "";
    final bool isLoading = ref.watch(loadingStateProvider);
    final _screenSize = MediaQuery.of(context).size;
    final productSnapshot = ref.watch(productSnapshotProvider);

    // Future<DocumentSnapshot> fetchProductData() async {
    //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
    //       .collection('items')
    //       .doc(docName)
    //       .get();
    //   return snapshot;
    // }

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        height: 850,
        child: Stack(children: [
          Container(
            width: double.infinity,
            // height: _screenSize.height,
            color: Color.fromARGB(255, 136, 238, 125),
          ),
          Positioned(
            left: 50,
            top: 0,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/Logistics_Isometric.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 60,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TitleText(
                text: 'Detail',
                color: Colors.white,
                size: 46,
              ),
            ]),
          ),
          Positioned(
            top: 300,
            child: Container(
              width: 400,
              height: 550,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(130, 0, 0, 0),
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                productSnapshot?['imageUrl'] != ""
                                    ? productSnapshot!['imageUrl']
                                    : nullUrl,
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Column(
                        children: [
                          CustomButtonGradation(
                              text: '入庫',
                              mainColor1: Color.fromARGB(255, 37, 167, 232),
                              mainColor2: Color.fromARGB(255, 9, 76, 176),
                              borderColor1: Color.fromARGB(255, 160, 196, 228),
                              borderColor2: Color.fromARGB(255, 1, 0, 57),
                              onPressed: () {
                                ref
                                    .read(incrementDialogStateProvider.notifier)
                                    .show();
                              },
                              width: 50,
                              height: 55,
                              textSize: 16,
                              textColor: Colors.white),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButtonGradation(
                              text: '出庫',
                              mainColor1: Color.fromARGB(255, 239, 118, 102),
                              mainColor2: Color.fromARGB(255, 180, 48, 25),
                              borderColor1: Color.fromARGB(255, 230, 180, 155),
                              borderColor2: Color.fromARGB(255, 126, 0, 0),
                              onPressed: () {
                                ref
                                    .read(decrementDialogStateProvider.notifier)
                                    .show();
                              },
                              width: 50,
                              height: 55,
                              textSize: 16,
                              textColor: Colors.white),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomButtonGradation(
                              text: '削除',
                              mainColor1: Color.fromARGB(255, 239, 118, 102),
                              mainColor2: Color.fromARGB(255, 180, 48, 25),
                              borderColor1: Color.fromARGB(255, 230, 180, 155),
                              borderColor2: Color.fromARGB(255, 126, 0, 0),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('削除確認'),
                                      content: Text(
                                          '"${productSnapshot?['productName']}"を削除します。\nよろしいですか？'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('キャンセル'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('削除'),
                                          onPressed: () async {
                                            FirebaseService service =
                                                FirebaseService();
                                            final deleteComment = await service
                                                .deleteData(docName);
                                            debugPrint(deleteComment);
                                            if (context.mounted) {
                                              context.go('/stock');
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              width: 50,
                              height: 30,
                              textSize: 16,
                              textColor: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AccountDetailView(
                        width: 85,
                        typeText: ' ID',
                        textContent: productSnapshot != null
                            ? (productSnapshot['productId'].toString())
                                .padLeft(5, '0')
                            : "",
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AccountDetailView(
                        width: 85,
                        typeText: ' 種類',
                        textContent: productSnapshot != null
                            ? (productSnapshot['productType'])
                            : "",
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      AccountDetailView(
                        width: 80,
                        typeText: ' 在庫数',
                        textContent: productSnapshot != null
                            ? (productSnapshot['productVolume'].toString())
                            : "",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  AccountDetailView(
                    typeText: ' 商品名',
                    textContent: productSnapshot != null
                        ? (productSnapshot['productName'])
                        : "",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Container(
                          width: 135,
                          alignment: Alignment.bottomLeft,
                          child: const Text(' 最終入庫',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.blueGrey.withOpacity(0.3),
                          ),
                          width: 130,
                          padding: const EdgeInsets.fromLTRB(7, 7, 0, 7),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                        productSnapshot != null
                                            ? productSnapshot[
                                                'finalInventoryPerson']
                                            : "",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16.0)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.event_note_sharp,
                                    color: Colors.black38,
                                  ),
                                  Text(
                                      productSnapshot != null
                                          ? productSnapshot[
                                              'finalInventoryDate']
                                          : "",
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(
                        width: 22,
                      ),
                      Column(children: [
                        Container(
                          width: 135,
                          alignment: Alignment.bottomLeft,
                          child: const Text(' 最終出庫',
                              style: TextStyle(
                                color: Colors.blueGrey,
                              )),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Colors.blueGrey.withOpacity(0.3),
                          ),
                          width: 130,
                          padding: const EdgeInsets.fromLTRB(7, 7, 0, 7),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.black38,
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: Text(
                                        productSnapshot != null
                                            ? productSnapshot[
                                                'finalExporterPerson']
                                            : "",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 16.0)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.event_note_sharp,
                                    color: Colors.black38,
                                  ),
                                  Text(
                                      productSnapshot != null
                                          ? productSnapshot['finalExporterDate']
                                          : "",
                                      style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
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
                  /////test
                  ///
                  CustomButtonGradation(
                      text: 'test',
                      mainColor1: Color.fromARGB(255, 94, 208, 161),
                      mainColor2: Color.fromARGB(255, 6, 100, 85),
                      borderColor1: Color.fromARGB(255, 222, 255, 195),
                      borderColor2: Color.fromARGB(255, 0, 100, 57),
                      onPressed: () {
                        context.go('/test');
                      },
                      width: 100,
                      height: 35,
                      textSize: 16,
                      textColor: Colors.white),
                ],
              ),
            ),
          ),
          if (ref.watch(incrementDialogStateProvider))
            Expanded(
              child: ColoredBox(
                color: Colors.black45,
                child: Container(
                  alignment: Alignment.center,
                  child: IncrementDialog(
                    docName,
                    username,
                  ),
                ),
              ),
            ),
          if (ref.watch(decrementDialogStateProvider))
            Expanded(
              child: ColoredBox(
                color: Colors.black45,
                child: Container(
                  alignment: Alignment.center,
                  child: DecrementDialog(
                    docName,
                    username,
                  ),
                ),
              ),
            ),
          if (isLoading)
            Container(
              height: _screenSize.height,
              width: _screenSize.width,
              decoration: const BoxDecoration(color: Colors.black54),
              child: const Align(
                alignment: Alignment(0, -0.5),
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              ),
            ),
        ]),
      )),
    );
  }
}
