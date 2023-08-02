import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/dailogs/detail_page_snack.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../dailogs/detail_page_dailog.dart';
import '../wedget/account_ditail_view.dart';
import '../wedget/custom_bottunGradation.dart';
import '../wedget/text_style.dart';

class DetailPage extends ConsumerWidget {
  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';

  const DetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String pruductNumber = ref.watch(detailProductProvider).toString();
    final String docName = 'product$pruductNumber';

    Stream<DocumentSnapshot> fetchUserData() {
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(ref.watch(userIdProvider));
      return userRef.snapshots();
    }

    Future<DocumentSnapshot> fetchProductData() async {
      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .doc(docName)
          .get();
      return querySnapshot;
    }

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: BoldText(size: 26, text: '在庫一覧', color: Colors.white),
            actions: [
              Row(children: [
                IconButton(
                    icon: const Icon(Icons.account_circle),
                    onPressed: () {
                      return context.go('/account');
                    }),
                Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  constraints: const BoxConstraints(
                    maxWidth: 70,
                  ),
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: fetchUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          DocumentSnapshot data = snapshot.data!;
                          return Text(
                            data['name'],
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                      }),
                ),
              ])
            ]),
        body: ListView(children: [
          Column(children: [
            Stack(children: [
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 275,
                  color: Color.fromARGB(255, 119, 228, 107),
                ),
              ),
              Positioned(
                left: 50,
                top: -50,
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
                  left: 0,
                  top: 250,
                  right: 0,
                  child: Container(
                    height: 25,
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: 'Detail',
                        color: Colors.white,
                        size: 46,
                      ),
                    ]),
              ),
            ]),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8.0),
                    constraints: const BoxConstraints(
                      maxWidth: 300,
                    ),
                    child: FutureBuilder<DocumentSnapshot>(
                        future: fetchProductData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                                          mainColor1:
                                              Color.fromARGB(255, 37, 167, 232),
                                          mainColor2:
                                              Color.fromARGB(255, 9, 76, 176),
                                          borderColor1: Color.fromARGB(
                                              255, 160, 196, 228),
                                          borderColor2:
                                              Color.fromARGB(255, 1, 0, 57),
                                          onPressed: () {
                                            // showMyDialog(context, docName);
                                            showSnackForm(context, docName);
                                          },
                                          width: 50,
                                          height: 80,
                                          textSize: 16,
                                          textColor: Colors.white),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomButtonGradation(
                                          text: '出庫',
                                          mainColor1: Color.fromARGB(
                                              255, 239, 118, 102),
                                          mainColor2:
                                              Color.fromARGB(255, 180, 48, 25),
                                          borderColor1: Color.fromARGB(
                                              255, 230, 180, 155),
                                          borderColor2:
                                              Color.fromARGB(255, 126, 0, 0),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                TextEditingController
                                                    valueController =
                                                    TextEditingController();
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 255, 226, 226),
                                                  title: const Text("出庫登録"),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(children: [
                                                      TextField(
                                                        controller:
                                                            valueController,
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText: "数量"),
                                                      ),
                                                    ]),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      child:
                                                          const Text("cancel"),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    TextButton(
                                                        child: const Text("出庫",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                        onPressed: () => (
                                                              //
                                                              //
                                                              //
                                                            )),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          width: 50,
                                          height: 80,
                                          textSize: 16,
                                          textColor: Colors.white),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AccountDetailView(
                                    width: 80,
                                    typeText: 'ID',
                                    // textContent: data['productId'].toString(),
                                    textContent: (data['productId'].toString())
                                        .padLeft(5, '0'),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  AccountDetailView(
                                    width: 80,
                                    typeText: '種類',
                                    textContent: data['productType'],
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  AccountDetailView(
                                    width: 80,
                                    typeText: '数量',
                                    textContent:
                                        data['productVolume'].toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              AccountDetailView(
                                typeText: '商品名',
                                textContent: data['productName'],
                              ),
                            ]);
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
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
            )
          ]),
        ]));
  }
}
