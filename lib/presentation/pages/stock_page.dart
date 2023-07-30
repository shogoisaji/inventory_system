import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/wedget/custom_bottun_circle.dart';
import 'package:flutter_test_various/presentation/wedget/text_style.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firestore_service.dart';
import '../wedget/custom_bottun.dart';
import '../wedget/image_download.dart';
import '../wedget/line_inner.dart';

class StockPage extends ConsumerWidget {
  StockPage({Key? key}) : super(key: key);

  final ScrollController _homeController = ScrollController();
  final String nullUrl =
      'https://firebasestorage.googleapis.com/v0/b/inventory-system-6bc22.appspot.com/o/images%2FNoImage.png?alt=media&token=95a23072-296e-4380-abd7-6dcb80ba647b';

  var images = {
    '部品': 'list_image1',
    '文房具': 'list_image2',
    '機器': 'list_image3',
    '消耗品': 'list_image4',
    '梱包材': 'list_image5'
  };

  var stockTypeList = ['部品', '文房具', '機器', '消耗品', '梱包材'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];

    Future<List<DocumentSnapshot>> fetchFilteredData() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('productType',
              isEqualTo: stockTypeList[ref.watch(stockTypeProvider)])
          .get();
      return querySnapshot.docs;
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: BoldText(size: 26, text: '在庫一覧', color: Colors.white),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          return context.go('/warehousing');
        },
        backgroundColor: const Color.fromARGB(255, 103, 103, 103),
        elevation: 5.0,
        label: BoldText(
          text: '入庫',
          size: 24,
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
          padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width) / 2 - 200),
          child: ListView.builder(
            itemCount: images.length,
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
                            "images/${images.values.elementAt(index)}.png",
                      ),
                      NormalText(
                          text: images.keys.elementAt(index),
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
        Expanded(
            child: Container(
          width: 400,
          height: double.infinity,
          child: Expanded(
            child: FutureBuilder<List<DocumentSnapshot>>(
                future: fetchFilteredData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
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
                        return Container(
                          width: 400,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 235, 235),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 0, 0, 72)
                                    .withOpacity(0.3),
                                offset: const Offset(2, 2),
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              // ImageDownload(imageUrl: data['productUrl']),
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          data['productUrl'] ?? nullUrl),
                                      // ) : const AssetImage('images/no_image.png'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
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
                                      color: Color.fromARGB(255, 209, 209, 209),
                                    ),
                                    child: Stack(children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 45,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          color: Color.fromARGB(
                                              255, 135, 135, 135),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: NormalText(
                                            text: '総数',
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 80.0),
                                        alignment: Alignment.centerLeft,
                                        child: NormalText(
                                          text:
                                              data['productVolume'].toString(),
                                          color: Colors.black,
                                          size: 20,
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
                                width: 10,
                              ),
                              CustomButton(
                                text: '詳細',
                                mainColor: Color.fromARGB(255, 174, 217, 224),
                                shadowColor: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.2),
                                onPressed: () => context.go('/shipping'),
                                width: 60,
                                height: 70,
                                textSize: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                text: '出庫',
                                mainColor:
                                    const Color.fromARGB(255, 255, 166, 158),
                                shadowColor: Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.2),
                                onPressed: () => context.go('/shipping'),
                                width: 60,
                                height: 70,
                                textSize: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
        ))
      ]),
    );
  }
}
