import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/wedget/custom_bottun_circle.dart';
import 'package:flutter_test_various/presentation/wedget/text_style.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../wedget/custom_bottun.dart';

class StockPage extends ConsumerWidget {
  StockPage({Key? key}) : super(key: key);

  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';

  var typeList = {
    '部品': 'list_image1',
    '文房具': 'list_image2',
    '機器': 'list_image3',
    '消耗品': 'list_image4',
    '梱包材': 'list_image5'
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userNameProvider) ?? "";
    final _screenSize = MediaQuery.of(context).size;

    Future<List<DocumentSnapshot>> fetchFilteredData() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('productType',
              isEqualTo: typeList.keys.elementAt(ref.watch(stockTypeProvider)))
          .get();
      return querySnapshot.docs;
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
                child: Text(
                  username,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ])
          ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          return context.go('/productRegistration');
        },
        backgroundColor: const Color.fromARGB(255, 103, 103, 103),
        elevation: 5.0,
        label: BoldText(
          text: '商品登録',
          size: 18,
          color: Colors.white,
        ),
        icon: const Icon(Icons.add),
      ),
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 231, 200, 183),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 130, 130, 130),
                offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 3,
              ),
            ],
          ),
          height: 95,
          child: ListView.builder(
            itemCount: typeList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return Row(
                children: [
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButtonCircle(
                        onPressed: () {
                          ref.read(stockTypeProvider.notifier).state = index;
                        },
                        assetName:
                            "images/${typeList.values.elementAt(index)}.png",
                      ),
                      NormalText(
                          text: typeList.keys.elementAt(index),
                          size: 14,
                          color: index == ref.watch(stockTypeProvider)
                              ? Colors.black.withOpacity(1.0)
                              : Colors.black.withOpacity(0.3)),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: _screenSize.height - 260,
          child: FutureBuilder<List<DocumentSnapshot>>(
              future: fetchFilteredData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(strokeWidth: 0.0);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<DocumentSnapshot> docs = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Color.fromARGB(0, 255, 255, 255),
                      thickness: 0,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data =
                          docs[index].data() as Map<String, dynamic>;
                      return Center(
                        child: Container(
                          width: 350,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 204, 216, 222),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 0, 0, 72)
                                    .withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
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
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: 150,
                                      child: NormalText(
                                        text: data['productName'],
                                        size: 14,
                                        color: Colors.black,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7.0),
                                      color: Color.fromARGB(255, 238, 238, 238),
                                    ),
                                    child: Row(children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 45,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color: Color.fromARGB(
                                              255, 150, 150, 150),
                                        ),
                                        child: NormalText(
                                          text: '数量',
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.only(left: 35.0),
                                        child: Text(
                                          data['productVolume'].toString(),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomButton(
                                text: '詳細',
                                mainColor: Color.fromARGB(255, 106, 219, 117),
                                shadowColor: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.2),
                                onPressed: () {
                                  ref
                                      .read(detailProductProvider.notifier)
                                      .state = data['productId'].toString();
                                  debugPrint(ref.watch(detailProductProvider));
                                  context.go('/detail');
                                },
                                width: 60,
                                height: 70,
                                textSize: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.0),
              Colors.black.withOpacity(0.5),
            ],
            stops: const [
              0.0,
              1.0,
            ],
          )),
        ))
      ]),
    );
  }
}
