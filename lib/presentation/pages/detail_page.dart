import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/dailogs/increment_snak.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../dailogs/decrement_snak.dart';
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
    final username = ref.watch(userNameProvider) ?? "";

    Future<DocumentSnapshot> fetchProductData() async {
      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .doc(docName)
          .get();
      return querySnapshot;
    }

    return Scaffold(
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                                      borderColor1:
                                          Color.fromARGB(255, 160, 196, 228),
                                      borderColor2:
                                          Color.fromARGB(255, 1, 0, 57),
                                      onPressed: () {
                                        // showMyDialog(context, docName);
                                        incrementSnackForm(
                                          context,
                                          docName,
                                          username,
                                        );
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
                                      mainColor1:
                                          Color.fromARGB(255, 239, 118, 102),
                                      mainColor2:
                                          Color.fromARGB(255, 180, 48, 25),
                                      borderColor1:
                                          Color.fromARGB(255, 230, 180, 155),
                                      borderColor2:
                                          Color.fromARGB(255, 126, 0, 0),
                                      onPressed: () {
                                        decrementSnackForm(
                                          context,
                                          docName,
                                          username,
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
                            height: 5.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AccountDetailView(
                                width: 85,
                                typeText: ' ID',
                                // textContent: data['productId'].toString(),
                                textContent: (data['productId'].toString())
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
                                typeText: ' 数量',
                                textContent: data['productVolume'].toString(),
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
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.blueGrey.withOpacity(0.3),
                                  ),
                                  width: 130,
                                  // height: 70,
                                  // alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 7, 0, 7),
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
                                                data['finalInventoryPerson'],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event_note_sharp,
                                            color: Colors.black38,
                                          ),
                                          Text(data['finalInventoryDate'],
                                              style: TextStyle(fontSize: 16.0)),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(7, 7, 0, 7),
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
                                                data['finalExporterPerson'],
                                                overflow: TextOverflow.ellipsis,
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
