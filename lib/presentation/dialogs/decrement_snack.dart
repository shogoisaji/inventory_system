import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_various/infrastructure/firebase/firebase_service.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';

class DecrementSnack extends HookConsumerWidget {
  final String docName;
  final String username;
  const DecrementSnack(this.docName, this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueController = useTextEditingController();

    return SizedBox(
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
                  fillColor: Color.fromARGB(255, 255, 220, 220),
                  helperStyle: TextStyle(color: Colors.white),
                  hintText: "数量",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 70, 70))),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  ref.read(decrementDialogProvider.notifier).hide();
                },
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 128, 119),
                  ),
                  child:
                      const Text('出庫', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    FirebaseService firebaseService = FirebaseService();
                    String currentValueString = await firebaseService.fetchData(
                            docName, 'productVolume') ??
                        "0";
                    final int currentValue = int.parse(currentValueString);

                    if (valueController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 200, 200),
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
                    } else if (currentValue < int.parse(valueController.text)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 200, 200),
                              title: const Text('在庫不足です',
                                  style: TextStyle(fontSize: 20)),
                              content: Text('在庫数は $currentValue です'),
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
                      // 減算

                      // final docRef = FirebaseFirestore.instance
                      //     .collection('items')
                      //     .doc(docName);
                      // FirebaseFirestore.instance
                      //     .runTransaction((Transaction tx) async {
                      //   DocumentSnapshot doc = await tx.get(docRef);
                      //   if (doc.exists) {
                      //     int currentValue = doc.get('productVolume');
                      //     if (currentValue >= int.parse(valueController.text)) {
                      //       tx.update(
                      //         docRef,
                      //         {
                      //           'productVolume': currentValue -
                      //               int.parse(valueController.text),
                      //           'finalExporterPerson': username,
                      //           'finalExporterDate': currentDate,
                      //         },
                      //       );
                      ref.read(loadingStateProvider.notifier).show();

                      Future.delayed(const Duration(seconds: 2), () {
                        context.go('/stock');
                        ref.read(decrementDialogProvider.notifier).hide();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    }
                  }),
            ],
          )
        ],
      ),
    );
  }
}
