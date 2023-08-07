import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firebase_service.dart';
import '../wedget/account_ditail_view.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/text_style.dart';

class DetailPage extends HookConsumerWidget {
  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';

  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String pruductNumber = ref.watch(detailProductProvider).toString();
    final String docName = 'product$pruductNumber';
    final username = ref.watch(userNameProvider) ?? "";
    final isLoading = ref.watch(loadingStateProvider);
    final _screenSize = MediaQuery.of(context).size;
    final productData = ref.watch(productDataProvider);

    ref.read(productDocumentProvider).change(docName);

    Future<DocumentSnapshot> fetchProductData() async {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('items')
          .doc(docName)
          .get();
      return snapshot;
    }

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
              child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      child: FutureBuilder<DocumentSnapshot>(
                          future: fetchProductData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: Color.fromARGB(0, 0, 0, 0),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              DocumentSnapshot data = snapshot.data!;
                              return Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              data['imageUrl'] != ""
                                                  ? data['imageUrl']
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
                                            mainColor1: Color.fromARGB(
                                                255, 37, 167, 232),
                                            mainColor2:
                                                Color.fromARGB(255, 9, 76, 176),
                                            borderColor1: Color.fromARGB(
                                                255, 160, 196, 228),
                                            borderColor2:
                                                Color.fromARGB(255, 1, 0, 57),
                                            onPressed: () {
                                              ref
                                                  .read(incrementDialogProvider
                                                      .notifier)
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
                                            mainColor1: Color.fromARGB(
                                                255, 239, 118, 102),
                                            mainColor2: Color.fromARGB(
                                                255, 180, 48, 25),
                                            borderColor1: Color.fromARGB(
                                                255, 230, 180, 155),
                                            borderColor2:
                                                Color.fromARGB(255, 126, 0, 0),
                                            onPressed: () {
                                              ref
                                                  .read(decrementDialogProvider
                                                      .notifier)
                                                  .show();
                                              // final snack = DecrementSnack(
                                              //     docName, username);
                                              // final snackBar = SnackBar(
                                              //   behavior:
                                              //       SnackBarBehavior.floating,
                                              //   duration:
                                              //       const Duration(minutes: 1),
                                              //   backgroundColor:
                                              //       const Color.fromARGB(
                                              //           255, 160, 30, 30),
                                              //   content: snack,
                                              // );
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(snackBar);
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
                                            mainColor1: Color.fromARGB(
                                                255, 239, 118, 102),
                                            mainColor2: Color.fromARGB(
                                                255, 180, 48, 25),
                                            borderColor1: Color.fromARGB(
                                                255, 230, 180, 155),
                                            borderColor2:
                                                Color.fromARGB(255, 126, 0, 0),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('削除確認'),
                                                    content: Text(
                                                        '"${data['productName']}"を削除します。\nよろしいですか？'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child:
                                                            const Text('キャンセル'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text('削除'),
                                                        onPressed: () {
                                                          FirebaseService
                                                              service =
                                                              FirebaseService();
                                                          final deleteComment =
                                                              service
                                                                  .deleteData(
                                                                      docName);
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AccountDetailView(
                                      width: 85,
                                      typeText: ' ID',
                                      textContent:
                                          (data['productId'].toString())
                                              .padLeft(5, '0'),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    AccountDetailView(
                                      width: 85,
                                      typeText: ' 種類',
                                      textContent: data['productType'],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    AccountDetailView(
                                      width: 80,
                                      typeText: ' 在庫数',
                                      textContent:
                                          data['productVolume'].toString(),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                AccountDetailView(
                                  typeText: ' 商品名',
                                  textContent: data['productName'],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
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
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color:
                                              Colors.blueGrey.withOpacity(0.3),
                                        ),
                                        width: 130,
                                        // height: 70,
                                        // alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.fromLTRB(
                                            7, 7, 0, 7),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  color: Colors.black38,
                                                ),
                                                Container(
                                                  width: 90,
                                                  child: Text(
                                                      data[
                                                          'finalInventoryPerson'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16.0)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.event_note_sharp,
                                                  color: Colors.black38,
                                                ),
                                                Text(data['finalInventoryDate'],
                                                    style: const TextStyle(
                                                        fontSize: 16.0)),
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
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color:
                                              Colors.blueGrey.withOpacity(0.3),
                                        ),
                                        width: 130,
                                        padding: const EdgeInsets.fromLTRB(
                                            7, 7, 0, 7),
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
                                                      data[
                                                          'finalExporterPerson'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16.0)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.event_note_sharp,
                                                  color: Colors.black38,
                                                ),
                                                Text(data['finalExporterDate'],
                                                    style: const TextStyle(
                                                        fontSize: 16.0)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ],
                                )
                              ]);
                            }
                          }),
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
                  ],
                ),
              ),
            ),
          ),
          // CustomDialog
          // SizedBox(
          //   width: _screenSize.width,
          //   height: _screenSize.height,
          //   child: Align(
          //       alignment: const Alignment(0, -0.3),
          //       child: IncrementDailog(docName, username)),
          // ),
          if (ref.watch(incrementDialogProvider))
            // if (true)
            Expanded(
              child: ColoredBox(
                color: Colors.black45,
                child: Container(
                  // padding: EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: IncrementDialog(
                    docName,
                    username,
                  ),
                ),
              ),
            ),
          if (ref.watch(decrementDialogProvider))
            // if (true)
            Expanded(
              child: ColoredBox(
                color: Colors.black45,
                child: Container(
                  // padding: EdgeInsets.only(top: 250),
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
