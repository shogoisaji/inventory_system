import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void showMyDialog(BuildContext context, String docName) {
  TextEditingController valueController = TextEditingController();
  showDialog(
    context: context,
    builder: (outerContext) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 220, 240, 255),
        title: const Text("入庫登録"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: valueController,
                decoration: const InputDecoration(hintText: "数量"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("cancel"),
            onPressed: () => Navigator.pop(outerContext), // 外側のダイアログを閉じる
          ),
          TextButton(
            child: const Text(
              "入庫",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () {
              if (valueController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    content: Center(
                        child:
                            Text('数量を入力してくださ', style: TextStyle(fontSize: 24))),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                final docRef =
                    FirebaseFirestore.instance.collection('items').doc(docName);
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
                      },
                    );
                  }
                });
                showDialog(
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
                  // Navigator.pop(context);
                  Navigator.pop(outerContext);
                });
              }
            },
          ),
        ],
      );
    },
  );
}
