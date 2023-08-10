import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/state/state.dart';
import '../../infrastructure/firebase/firebase_service.dart';

class DecrementDialog extends HookConsumerWidget {
  final String docName;
  final String username;
  const DecrementDialog(this.docName, this.username, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valueController = useTextEditingController();
    FirebaseService fireServise = FirebaseService();

    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 166, 77, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 300,
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
                  fillColor: Color.fromARGB(255, 255, 234, 220),
                  helperStyle: TextStyle(color: Colors.white),
                  hintText: "数量",
                  hintStyle: TextStyle(color: Colors.orange)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'キャンセル',
                  style: TextStyle(color: Colors.orange),
                ),
                onPressed: () {
                  ref.read(decrementDialogStateProvider.notifier).hide();
                },
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 230, 92, 6),
                ),
                child: const Text('出庫',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                onPressed: () async {
                  final decrementValue = int.parse(valueController.text);
                  Map<String, dynamic>? data =
                      await fireServise.fetchProductData(docName);

                  final int currentValue = data!['productVolume'];
                  debugPrint(currentValue.toString());
                  if (valueController.text.isEmpty) {
                    if (context.mounted) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 200, 200),
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
                    }
                  } else if (currentValue <= int.parse(valueController.text)) {
                    if (context.mounted) {
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
                    }
                  } else {
                    ref.read(loadingStateProvider.notifier).show();

                    FirebaseService firebaseService = FirebaseService();

                    firebaseService.decrementVolume(
                        docName, username, decrementValue);

                    Future.delayed(const Duration(seconds: 2), () {
                      context.go('/stock');
                      ref.read(decrementDialogStateProvider.notifier).hide();
                      ref.read(loadingStateProvider.notifier).hide();
                    });
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
