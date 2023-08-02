import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void showSnackForm(
    BuildContext context, String docName, double iconController) {
  TextEditingController valueController = TextEditingController();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(minutes: 1),
    backgroundColor: Color.fromARGB(255, 0, 81, 147),
    content: Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('数量を入力してくださ', style: TextStyle(fontSize: 24)),
          Transform.rotate(
            angle: iconController * 6.28, // 回転角度（ラジアン）
            child: Icon(Icons.refresh, size: 50),
          ),
          // const SizedBox(
          //   height: 15,
          // ),
          SizedBox(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: valueController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 220, 230, 255),
                  helperStyle: TextStyle(color: Colors.white),
                  hintText: "数量",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 70, 172, 255))),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('キャンセル'),
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: const Text('入庫', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return const Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   },
                  //   barrierDismissible: false,
                  // );
                  Future.delayed(const Duration(seconds: 2), () {
                    // Navigator.pop(context);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  });
                },
              ),
            ],
          )
        ],
      ),
    ),
  ));

  // showDialog(
  //   context: context,
  //   builder: (outerContext) {
  //     return AlertDialog(
  //       backgroundColor: Color.fromARGB(255, 220, 240, 255),
  //       title: const Text("入庫登録"),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: [
  //             TextField(
  //               keyboardType: TextInputType.number,
  //               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //               controller: valueController,
  //               decoration: const InputDecoration(hintText: "数量"),
  //             ),
  //           ],
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           child: const Text("cancel"),
  //           onPressed: () => Navigator.pop(outerContext), // 外側のダイアログを閉じる
  //         ),
  //         TextButton(
  //           child: const Text(
  //             "入庫",
  //             style: TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //           onPressed: () {
  //             if (valueController.text.isEmpty) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   elevation: 10,
  //                   behavior: SnackBarBehavior.floating,
  //                   backgroundColor: Colors.red,
  //                   content: Center(
  //                       child:
  //                           Text('数量を入力してくださ', style: TextStyle(fontSize: 24))),
  //                   duration: Duration(seconds: 2),
  //                 ),
  //               );
  //             } else {
  //               final docRef =
  //                   FirebaseFirestore.instance.collection('items').doc(docName);
  //               FirebaseFirestore.instance
  //                   .runTransaction((Transaction tx) async {
  //                 DocumentSnapshot doc = await tx.get(docRef);
  //                 if (doc.exists) {
  //                   int currentValue = doc.get('productVolume');
  //                   tx.update(
  //                     docRef,
  //                     {
  //                       'productVolume':
  //                           currentValue + int.parse(valueController.text),
  //                     },
  //                   );
  //                 }
  //               });
  //               showDialog(
  //                 context: context,
  //                 builder: (context) {
  //                   return const Center(
  //                     child: CircularProgressIndicator(),
  //                   );
  //                 },
  //                 barrierDismissible: false,
  //               );
  //               Future.delayed(const Duration(seconds: 2), () {
  //                 context.go('/stock');
  //                 // Navigator.pop(context);
  //                 Navigator.pop(outerContext);
  //               });
  //             }
  //           },
  //         ),
  //       ],
  //     );
  //   },
  // );
}