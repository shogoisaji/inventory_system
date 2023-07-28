import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test_various/presentation/wedget/text_style.dart';
import 'package:go_router/go_router.dart';

import '../../application/state/state.dart';
import '../wedget/line_inner.dart';

class StockPage extends ConsumerWidget {
  StockPage({Key? key}) : super(key: key);

  final ScrollController _homeController = ScrollController();

  var images = {
    '部品':'list_image1',
    '文房具':'list_image2',
    '機器':'list_image3',
    '消耗品':'list_image4',
    '梱包材':'list_image5'
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    String email = user!.email!;
    String username = email.split('@')[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BoldText(size:26, text:'在庫一覧', color:Colors.white),
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
      body: Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 231, 200, 183),
            boxShadow:  [
              BoxShadow(
                color: Color.fromARGB(255, 130, 130, 130),
                offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 3,
              ),
            ],
          ), 
          height: 95,
          padding: EdgeInsets.only(left:  (MediaQuery.of(context).size.width)/2-200),
          child: ListView.builder(
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("images/${images.values.elementAt(index)}.png"),
                        fit: BoxFit.contain
                      ),
                    ),
                  ),
                  // SizedBox(height: 10,),
                  NormalText(
                    text: images.keys.elementAt(index),
                    size: 14,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 5,),
        Expanded(
          child: Container(
            width: 500,
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, typeIndex) {
                return Container(
                  width: 500,
                  height: double.infinity,
                  child: Expanded(
                    child: ListView.separated(
                      controller: _homeController,
                      itemBuilder: (BuildContext context, int typeIndex) {
                        return Container(
                          alignment: Alignment.center,
                          child: ListInner(indexNumber: (typeIndex + 1)),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(
                        color: Color.fromARGB(0, 255, 255, 255),
                        thickness: 0,
                      ),
                      itemCount: 30
                    ),
                  ),
                );
              }
            ),
          ),
        ),
      ],
    ),
    );
  }
}
