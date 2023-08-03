import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../wedget/date_get.dart';

void incrementSnackForm(BuildContext context, String docName, String username) {
  TextEditingController valueController = TextEditingController();
  String currentDate = getCurrentDate();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    duration: const Duration(minutes: 1),
    backgroundColor: const Color.fromARGB(255, 0, 81, 147),
    content: SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('数量を入力してくださ', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 15,
          ),
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
                  if (valueController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color.fromARGB(255, 255, 200, 200),
                            title: const Text('数量を入力してください',
                                style: TextStyle(fontSize: 20)),
                            actions: [
                              TextButton(
                                child: const Text("OK",
                                    style: TextStyle(fontSize: 20.0)),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        });
                  } else {
                    final docRef = FirebaseFirestore.instance
                        .collection('items')
                        .doc(docName);
                    FirebaseFirestore.instance
                        .runTransaction((Transaction tx) async {
                      DocumentSnapshot doc = await tx.get(docRef);
                      if (doc.exists) {
                        int currentValue = doc.get('productVolume');
                        tx.update(
                          docRef,
                          {
                            'productVolume':
                                currentValue + int.parse(valueController.text),
                            'finalInventoryPerson': username,
                            'finalInventoryDate': currentDate,
                          },
                        );
                      }
                    });
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
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    });
                  }
                },
              ),
            ],
          )
        ],
      ),
    ),
  ));
}
